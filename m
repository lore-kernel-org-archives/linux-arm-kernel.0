From: frankyl@broadcom.com (Franky Lin)
Date: Tue, 26 Jun 2012 11:20:39 -0700
Subject: Panda ES board hang when using GPIO as interrupt
In-Reply-To: <CAC83ZvL2ozQD1DYmtKeFa1PB1pZ1JmBUKFWmDWnbJOCDL3sKNg@mail.gmail.com>
References: <4FE8CF77.5080400@broadcom.com>
 <CAC83ZvL2ozQD1DYmtKeFa1PB1pZ1JmBUKFWmDWnbJOCDL3sKNg@mail.gmail.com>
Message-ID: <4FE9FD77.7050807@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2012 12:21 AM, DebBarma, Tarun Kanti wrote:
> On Tue, Jun 26, 2012 at 2:22 AM, Franky Lin <frankyl@broadcom.com> wrote:
>> Hi Kevin, Tarun,
>>
>> We are using the expansion connector A on Panda board to mount a SDIO WiFi
>> dongle on MMC2 with a level triggered interrupt signal connected to GPIO
>> 138. It's been working fine until 3.5 rc1. The board hang randomly within 5
>> mins during a network traffic test. After bisecting we found the culprit is
>> "[PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()" [1].
>>
>> I noticed Kevin raised some similar cases on other platforms and also
>> provided two patches in the patch mail thread. But unfortunately those two
>> patches doesn't help in our case. I tested the driver with 3.5-rc3 mainline
>> kernel and the issue is still there. I can only "fix" the hang by either
>> reverting the commit or disabling CONFIG_PM_RUNTIME. Also, the hang only
>> happens on Panda ES board. Old Panda with 4430 works good.
>>
>> Any thoughts and suggestions?
> I just had a quick look at the code. Can you please check if the
> attached patch solves
> the issue? I just boot tested on Panda and Blaze.
> --
> Tarun
>

Thanks for the prompt reply.

Booting is fine even without the patch and revert. The wifi dongle 
generates interrupt whenever there is data packet available for host to 
read. So during a traffic test a significant numbers of interrupt will 
be triggered through the GPIO. So I assume it has something to do with 
the interrupt GPIO.

With the patch, the kernel still crashes. But the symptom is slightly 
different. Now it has a panic log every time. See attachment.

Regards,
Franky
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: panic.log
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/aa313b28/attachment.ksh>
