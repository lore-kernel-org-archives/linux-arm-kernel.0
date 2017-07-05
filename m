From: qiaozhou@asrmicro.com (qiaozhou)
Date: Wed, 5 Jul 2017 11:16:53 +0800
Subject: [PATCH] arm64: traps: disable irq in die()
In-Reply-To: <20170704171746.GM22175@arm.com>
References: <1498640652-23338-2-git-send-email-qiaozhou@asrmicro.com>
 <20170704171746.GM22175@arm.com>
Message-ID: <8a0574f5-acb7-2aca-00b5-8c82742bfa24@asrmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017?07?05? 01:17, Will Deacon wrote:
> On Wed, Jun 28, 2017 at 05:04:12PM +0800, Qiao Zhou wrote:
>> In current die(), the irq is disabled for __die() handle, not
>> including the possible panic() handling. Since the log in __die()
>> can take several hundreds ms, new irq might come and interrupt
>> current die().
>>
>> If the process calling die() holds some critical resource, and some
>> other process scheduled later also needs it, then it would deadlock.
>> The first panic will not be executed.
>>
>> So here disable irq for the whole flow of die().
> Could you give an example of this going wrong, please?
OK. I'll add one piece of  log at the bottom and add some descriptions.
>
>> Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
>> ---
>>   arch/arm64/kernel/traps.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 0805b44..b12bf0f 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -274,10 +274,13 @@ static DEFINE_RAW_SPINLOCK(die_lock);
>>   void die(const char *str, struct pt_regs *regs, int err)
>>   {
>>   	int ret;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>>   
>>   	oops_enter();
>>   
>> -	raw_spin_lock_irq(&die_lock);
>> +	raw_spin_lock(&die_lock);
> Can we instead move the taking of the die_lock before oops_enter, or does
> that break something else?
It's OK to move. I just didn't want to change the original place for 
taking the lock.
>
>>   	console_verbose();
>>   	bust_spinlocks(1);
>>   	ret = __die(str, err, regs);
>> @@ -287,13 +290,16 @@ void die(const char *str, struct pt_regs *regs, int err)
>>   
>>   	bust_spinlocks(0);
>>   	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>> -	raw_spin_unlock_irq(&die_lock);
>> +	raw_spin_unlock(&die_lock);
>>   	oops_exit();
>>   
>>   	if (in_interrupt())
>>   		panic("Fatal exception in interrupt");
>>   	if (panic_on_oops)
>>   		panic("Fatal exception");
>> +
>> +	local_irq_restore(flags);
> We could also move the unlock_irq down here.
You're right.
>
> Will
Here is the sample log. The sequence is: core0 exception -> core0 exec 
die -> core0 interrupted -> core9 detect hardlockup on core0, set core0 
pc to 0 -> core0 exception again. The last exception shows the complete 
stack.

In the first exception(5716.xx), core0 holds rq->lock and tries to 
activate_task, and didn't release the lock yet. In the second exception, 
the stack shows core0 tries to get the same rq->lock in scheduler_tick, 
but can never get it. So hardlockup is detected.

[ 5716.045688] c0 0 (swapper/0) Unable to handle kernel paging request 
at virtual address fffff9b5eed015b5
[ 5716.055132] c0 0 (swapper/0) pgd = ffffffc0a9415000
[ 5716.060024] c0 0 (swapper/0) [fffff9b5eed015b5] 
*pgd=0000000000000000, *pud=0000000000000000
[ 5716.067038] c0 0 (swapper/0) Internal error: Oops: 96000044 [#1] 
PREEMPT SMP
[ 5716.074096] c0 0 (swapper/0) Modules linked in: snd_soc_asr_88pm860 
snd_soc_asr snd_soc_88pm88x_headset snd_soc_88pm860 nanohub_aipc adsp
[ 5716.085108] c0 0 (swapper/0) CPU: 0 PID: 0 Comm: swapper/0 Tainted: 
G    B           4.4.35+ #1
[ 5716.093821] c0 0 (swapper/0) Hardware name: ASR AQUILA EVB (DT)
[ 5716.099764] c0 0 (swapper/0) task: ffffff8008e56cc0 ti: 
ffffff8008e40000 task.ti: ffffff8008e40000
[ 5716.108752] c0 0 (swapper/0) PC is at dequeue_rt_stack+0x64/0x2c0
[ 5716.114871] c0 0 (swapper/0) LR is at dequeue_rt_stack+0x50/0x2c0
[ 5716.120977] c0 0 (swapper/0) pc : [<ffffff80080e6090>] lr : 
[<ffffff80080e607c>] pstate: 200001c5
[ 5716.129863] c0 0 (swapper/0) sp : ffffffc0fded2db0
[ 5716.134667] c0 0 (swapper/0) x29: ffffffc0fded2db0 x28: 0000000000000002
[ 5716.140012] c0 0 (swapper/0) x27: ffffff8008c2d000 x26: 0000000000000000
[ 5716.145359] c0 0 (swapper/0) x25: ffffff8008e49028 x24: 00000000000001c0
[ 5716.150706] c0 0 (swapper/0) x23: ffffffc0fded9280 x22: 0000000000000001
[ 5716.156052] c0 0 (swapper/0) x21: 0000000000000064 x20: ffffffc0fded93e8
[ 5716.161400] c0 0 (swapper/0) x19: ffffffc0eed092e8 x18: 0000000000000000
[ 5716.166748] c0 0 (swapper/0) x17: 0000000000000000 x16: 0000000000000000
[ 5716.172095] c0 0 (swapper/0) x15: 0000000000000000 x14: 0000000000000000
[ 5716.177442] c0 0 (swapper/0) x13: 0000000000000000 x12: 0000000034d5d91d
[ 5716.182789] c0 0 (swapper/0) x11: 0000000000000000 x10: 0000000000001000
[ 5716.188137] c0 0 (swapper/0) x9 : ffffff8008083800 x8 : ffffff8008e46ff0
[ 5716.193484] c0 0 (swapper/0) x7 : 0000000000000000 x6 : 0000001aa6db7e28
[ 5716.198830] c0 0 (swapper/0) x5 : 0000000000000015 x4 : 00000532dde29330
[ 5716.204178] c0 0 (swapper/0) x3 : ffffff80080e7060 x2 : 0000000000000005
[ 5716.209525] c0 0 (swapper/0) x1 : ffff3d77eed0f7f5 x0 : fffff9b5eed015ad
[ 5716.214881] c0 0 (swapper/0)
                SP: 0xffffffc0fded2d30:

[.......]   // printing stack/call trace of core0.

[ 5716.700455] c0 0 (swapper/0) [<ffffff80080e6090>] 
dequeue_rt_stack+0x64/0x2c0
[ 5716.707616] c0 0 (swapper/0) [<ffffff80080e70ac>] 
enqueue_task_rt+0x4c/0xf8
[ 5716.714604] c0 0 (swapper/0) [<ffffff80080ce1d0>] activate_task+0x78/0xbc
[ 5716.721418] c0 0 (swapper/0) [<ffffff80080d021c>] 
try_to_wake_up+0x22c/0x454
[ 5716.728491] c0 0 (swapper/0) [<ffffff80080d046c>] 
wake_up_process+0x28/0x34
[ 5716.735485] c0 0 (swapper/0) [<ffffff80080ff5c0>] 
__irq_wake_thread+0x74/0x80
[ 5716.742647] c0 0 (swapper/0) [<ffffff80080ff68c>] 
handle_irq_event_percpu+0xc0/0x288
[ 5716.750412] c0 0 (swapper/0) [<ffffff80080ff8a0>] 
handle_irq_event+0x4c/0x7c
[ 5716.757486] c0 0 (swapper/0) [<ffffff8008103368>] 
handle_fasteoi_irq+0xbc/0x1bc
[ 5716.764824] c0 0 (swapper/0) [<ffffff80080feee4>] 
__handle_domain_irq+0x7c/0xd4
[ 5716.772156] c0 0 (swapper/0) [<ffffff80080816e8>] 
gic_handle_irq+0xf4/0x19c
[ 5716.779137] c0 0 (swapper/0) Exception stack(0xffffff8008e43d30 to 
0xffffff8008e43e60)
[ 5716.787074] c0 0 (swapper/0) 3d20:                                   
0000000000000000 ffffff8008e40000
[ 5716.796400] c0 0 (swapper/0) 3d40: ffffff80086c9a24 00000000000003e8 
0000000006a7ef9e 002a332b14ce0580
[ 5716.805732] c0 0 (swapper/0) 3d60: 00000022a0967988 0000000000000019 
00000032b5193519 ffffff8008083800
[ 5716.815062] c0 0 (swapper/0) 3d80: 0000000000001000 0000000000000000 
0000000034d5d91d 0000000000000000
[ 5716.824386] c0 0 (swapper/0) 3da0: 0000000000000000 0000000000000000 
0000000000000000 0000000000000000
[ 5716.833718] c0 0 (swapper/0) 3dc0: 0000000000000000 00000532c0426a5d 
ffffffc0f3548e00 0000000000000004
[ 5716.843050] c0 0 (swapper/0) 3de0: ffffff8008ec8cf8 0000000000000001 
00000532bf48699d ffffff8008f09908
[ 5716.852381] c0 0 (swapper/0) 3e00: 0000000000000000 ffffff80089b0000 
ffffff8008e40000 ffffff8008e43e60
[ 5716.861712] c0 0 (swapper/0) 3e20: ffffff80086a48fc ffffff8008e43e60 
ffffff80086a4870 0000000020000145
[ 5716.871046] c0 0 (swapper/0) 3e40: ffffff8008e43e60 ffffff80086a48fc 
ffffffffffffffff 00000000ffffffff
[ 5716.880376] c0 0 (swapper/0) [<ffffff80080847b4>] el1_irq+0xb4/0x12c
[ 5716.886759] c0 0 (swapper/0) [<ffffff80086a4870>] 
cpuidle_enter_state+0x15c/0x354
[ 5716.894264] c0 0 (swapper/0) [<ffffff80086a4adc>] cpuidle_enter+0x34/0x40
[ 5716.901083] c0 0 (swapper/0) [<ffffff80080eb104>] 
cpu_startup_entry+0x2a8/0x3b4
[ 5716.908419] c0 0 (swapper/0) [<ffffff800899b954>] rest_init+0x88/0x90
[ 5716.914885] c0 0 (swapper/0) [<ffffff8008d78af4>] 
start_kernel+0x45c/0x488
[ 5716.921778] c0 0 (swapper/0) [<ffffff8008080218>] 0xffffff8008080218
[ 5716.928157] c0 0 (swapper/0) Code: eb00027f 540006c0 f9400661 
f9401e74 (f9000401)
[ 5718.997862] c7 1278 (kworker/u21:0) i2c-asr d4018800.i2c: fifo 
transfer timeout
[ 5719.005505] c7 1278 (kworker/u21:0) i2c-asr d4018800.i2c: i2c 
transfer error
[ 5719.513830] c7 1278 (kworker/u21:0) i2c-asr d4018800.i2c: fifo 
transfer timeout
[ 5719.521474] c7 1278 (kworker/u21:0) i2c-asr d4018800.i2c: i2c 
transfer error

[.......]  // some log on other cores

[ 5724.721523] c9 30564 (Binder:259_2) NMI watchdog: BUG: CPU9 detected 
hard LOCKUP on CPU0
                will trigger panic on CPU0 via coresight
[ 5724.734560] c9 30564 (Binder:259_2) =========== dump PCSR for cpu0 
===========
[ 5724.741779] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.748317] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.754854] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.761390] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.767926] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.774463] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.780999] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.787536] c9 30564 (Binder:259_2) PCSR of cpu0 is 0xffffff80089a35b8
[ 5724.794069] c9 30564 (Binder:259_2) Going to halt cpu0
[ 5724.799212] c9 30564 (Binder:259_2) Going to insert inst on cpu0
[ 5724.805207] c9 30564 (Binder:259_2) Going to restart cpu0
[ 5724.810622] c0 0 (swapper/0) Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
[ 5724.820206] c0 0 (swapper/0) pgd = ffffff8008fd5000
[ 5724.825093] c0 0 (swapper/0) [00000000] *pgd=00000001fdffe003, 
*pud=00000001fdffe003, *pmd=0000000000000000
[ 5724.833424] c0 0 (swapper/0) Internal error: Oops: 86000005 [#2] 
PREEMPT SMP
[ 5724.840482] c0 0 (swapper/0) Modules linked in: snd_soc_asr_88pm860 
snd_soc_asr snd_soc_88pm88x_headset snd_soc_88pm860 nanohub_aipc adsp
[ 5724.851483] c0 0 (swapper/0) CPU: 0 PID: 0 Comm: swapper/0 Tainted: 
G    B D         4.4.35+ #1
[ 5724.860194] c0 0 (swapper/0) Hardware name: ASR AQUILA EVB (DT)
[ 5724.866135] c0 0 (swapper/0) task: ffffff8008e56cc0 ti: 
ffffff8008e40000 task.ti: ffffff8008e40000
[ 5724.875107] c0 0 (swapper/0) PC is at 0x0
[ 5724.879145] c0 0 (swapper/0) LR is at scheduler_tick+0x4c/0x2bc
[ 5724.885081] c0 0 (swapper/0) pc : [<0000000000000000>] lr : 
[<ffffff80080d1a78>] pstate: 000001c5

[.......]  // printing stack/call trace of core0.

[ 5725.385206] c0 0 (swapper/0) 2620: ffffff8008e47000 2030633630303034
[ 5725.391573] c0 0 (swapper/0) [<          (null)>] (null)
[ 5725.397783] c0 0 (swapper/0) [<ffffff80080d1a78>] 
scheduler_tick+0x4c/0x2bc
[ 5725.404774] c0 0 (swapper/0) [<ffffff8008114c80>] 
update_process_times+0x58/0x70
[ 5725.412195] c0 0 (swapper/0) [<ffffff80081265a8>] 
tick_sched_timer+0x74/0xf4
[ 5725.419268] c0 0 (swapper/0) [<ffffff800811532c>] 
__hrtimer_run_queues+0x158/0x39c
[ 5725.426862] c0 0 (swapper/0) [<ffffff80081160b8>] 
hrtimer_interrupt+0xa4/0x1e8
[ 5725.434114] c0 0 (swapper/0) [<ffffff80086c986c>] 
arch_timer_handler_phys+0x3c/0x48
[ 5725.441793] c0 0 (swapper/0) [<ffffff8008103bc8>] 
handle_percpu_devid_irq+0x94/0x1d4
[ 5725.449565] c0 0 (swapper/0) [<ffffff80080feee4>] 
__handle_domain_irq+0x7c/0xd4
[ 5725.456895] c0 0 (swapper/0) [<ffffff80080816e8>] 
gic_handle_irq+0xf4/0x19c
[ 5725.463877] c0 0 (swapper/0) Exception stack(0xffffffc0fded2980 to 
0xffffffc0fded2ab0)
[ 5725.471818] c0 0 (swapper/0) 2980: ffffffc0fded29c0 0000008000000000 
ffffffc0fded2af0 ffffff80089a398c
[ 5725.481147] c0 0 (swapper/0) 29a0: 0000000060000145 ffffff8008e56cc0 
ffffffc0fded0000 0000000000000000
[ 5725.490481] c0 0 (swapper/0) 29c0: 0000000000000001 ffffff8008f3c8d0 
00000000000000a0 0000000000000080
[ 5725.499811] c0 0 (swapper/0) 29e0: 0000000000000001 0000000000000000 
0000000000000056 ffffff8008e88f18
[ 5725.509145] c0 0 (swapper/0) 2a00: ffffff80083109c4 6177732820302030 
2029302f72657070 6265203a65646f43
[ 5725.518472] c0 0 (swapper/0) 2a20: 3520663732303030 2030633630303034 
3136363030343966 0000000000000000
[ 5725.527798] c0 0 (swapper/0) 2a40: 0000000000000000 0000000000000000 
0000000000000000 ffffff8008f3c0f8
[ 5725.537129] c0 0 (swapper/0) 2a60: ffffffc0fded2c80 0000000000000001 
ffffff8008c221e0 ffffff8008e40000
[ 5725.546462] c0 0 (swapper/0) 2a80: ffffff8008e56cc0 ffffff8008e49028 
0000000000000000 ffffff8008c2d000
[ 5725.555786] c0 0 (swapper/0) 2aa0: ffffff8008e40000 ffffffc0fded2af0
[ 5725.562163] c0 0 (swapper/0) [<ffffff80080847b4>] el1_irq+0xb4/0x12c
[ 5725.568549] c0 0 (swapper/0) [<ffffff800808a154>] die+0xd8/0x1d4
[ 5725.574579] c0 0 (swapper/0) [<ffffff800809b91c>] 
__do_kernel_fault.part.6+0x7c/0x90
[ 5725.582345] c0 0 (swapper/0) [<ffffff8008098bf4>] 
ptep_set_access_flags+0x0/0xb0
[ 5725.589766] c0 0 (swapper/0) [<ffffff80080812d4>] do_mem_abort+0x64/0xdc
[ 5725.596483] c0 0 (swapper/0) Exception stack(0xffffffc0fded2bc0 to 
0xffffffc0fded2cf0)
