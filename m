From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Nov 2016 13:37:04 +0000
Subject: Unable to use perf in VM
In-Reply-To: <8b2a3cfd-57a0-70ac-ef50-672f8040291d@arm.com>
References: <70374841-ecb1-a6c3-ed43-0f39e2d5fec2@riken.jp>
 <8b2a3cfd-57a0-70ac-ef50-672f8040291d@arm.com>
Message-ID: <a81f82da-322a-a52b-de0e-316b7ce5f463@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/16 11:48, Marc Zyngier wrote:
> + Shannon
> 
> On 29/11/16 22:04, Itaru Kitayama wrote:
>> Hi,
>>
>> In a VM (virsh controlled, KVM acceleration enabled) on a recent
>> kvmarm kernel host, I find I am unable to use perf to obtain
>> performance statistics for a complex task like kernel build.
>> (I've verified this is seen with a Fedora 25 VM and host combination
>> as well)
>> APM folks CC'ed think this might be caused by a bug in the core PMU 
>> framework code, thus I'd like to have experts opinion on this issue.
>>
>> [root at localhost linux]# perf stat -B make
>>    CHK     include/config/kernel.release
>> [  119.617684] git[1144]: undefined instruction: pc=fffffc000808ff30
>> [  119.623040] Code: 51000442 92401042 d51b9ca2 d5033fdf (d53b9d40)
>> [  119.627607] Internal error: undefined instruction: 0 [#1] SMP
> 
> [...]
> 
> In a VM running mainline hosted on an AMD Seattle box:
> 
>  Performance counter stats for 'make':
> 
>     1526089.499304      task-clock:u (msec)       #    0.932 CPUs utilized          
>                  0      context-switches:u        #    0.000 K/sec                  
>                  0      cpu-migrations:u          #    0.000 K/sec                  
>           29527793      page-faults:u             #    0.019 M/sec                  
>      2913174122673      cycles:u                  #    1.909 GHz                    
>      2365040892322      instructions:u            #    0.81  insn per cycle         
>    <not supported>      branches:u                                                  
>        32049215378      branch-misses:u           #    0.00% of all branches        
> 
>     1637.531444837 seconds time elapsed
> 
> Running the same host kernel on a Mustang system, the guest explodes
> in the way you reported. The failing instruction always seems to be
> an access to pmxevcntr_el0 (I've seen both reads and writes).
> 
> Funnily enough, it dies if you try any HW event other than cycles
> ("perf stat -e cycles ls" works, and "perf stat -e instructions ls"
> explodes). Which would tend to indicate that we're screwing up
> the counter selection, but I have no proof of that (specially that
> the Seattle guest is working just as expected).

It turns out that we *don't* inject an undef. It seems to be generated
locally at EL1.

Still digging.

	M.
-- 
Jazz is not dead. It just smells funny...
