From: stefan@agner.ch (Stefan Agner)
Date: Fri, 28 Nov 2014 17:00:00 +0100
Subject: [RFC 0/7] ARM: vf610m4: Add Vybrid Cortex-M4 support
In-Reply-To: <54788417.6020408@suse.de>
References: <cover.1413136383.git.stefan@agner.ch> <54788417.6020408@suse.de>
Message-ID: <f176fb225d8679645fcfad4a98761f98@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 2014-11-28 15:17, Andreas F?rber wrote:
> Hi Stefan,
> 
> Am 12.10.2014 um 20:13 schrieb Stefan Agner:
>> One thing I noticed that when I move the xipImage below the DRAM base
>> address, the kernel freezes:
>> ...
>> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
>> [freeze]
>>
>> I think it happens when the scheduler gets started. Any idea what could
>> go wrong here?
> 
> I ran into a similar issue on STM32F4 recently - hanging there, or:
> 
> Unhandled exception: IPSR = 00000006 LR = fffffff1
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc5-00003-g489983a-dirty #25
> task: 90432000 ti: 90434000 task.ti: 90434000
> 
> Unhandled exception: IPSR = 00000003 LR = fffffff1
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.18.0-rc5-00003-g489983a-dirty #25
> task: 90432000 ti: 90434000 task.ti: 90434000
> -Boot 2010.03-00003-g934021a-dirty (Nov 26 2014 - 06:52:49)
> 
> My debugging indicated that %pF was not working, used among others in
> checking for blacklisted initcalls. Disabling CONFIG_KALLSYMS worked
> around this, so I assume something there is not compatible with XIP...

Hm, interesting! So it needs to be somewhere in lib/vsprintf.c or even
kernel/kallsyms.c. If XIP is incompatible with the KALLSYMS, we should
fix this dependency. Maybe it's easily fixable, however I did not look
into that symbolic stuff. I would be helpful to have symbols even on M4
thought :-) Will probably have a look into it this weekend.

--
Stefan


> 
> Regards,
> Andreas
