From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 23 Oct 2012 20:19:19 +0530
Subject: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling
 hwmod
In-Reply-To: <87txtlb6v7.fsf@deeprootsystems.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1210230745160.32436@utopia.booyaka.com>
 <87txtlb6v7.fsf@deeprootsystems.com>
Message-ID: <5086AE6F.5030409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 October 2012 07:58 PM, Kevin Hilman wrote:
> Paul Walmsley <paul@pwsan.com> writes:
>
>> Hi Tero,
>>
>> On Mon, 22 Oct 2012, Tero Kristo wrote:
>>
>>> When waking up from off-mode, some IP blocks are reset automatically by
>>> hardware. For this reason, software must wait until the reset has
>>> completed before attempting to access the IP block.
>>>
>>> This patch fixes for example the bug introduced by commit
>>> 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
>>> to SYSCONFIG register"), in which the MMC IP block is reset during
>>> off-mode entry, but the code expects the module to be already available
>>> during the execution of context restore.
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> Cc: Paul Walmsley <paul@pwsan.com>
>>> Cc: Benoit Cousson <b-cousson@ti.com>
>>> Cc: Venkatraman S <svenkatr@ti.com>
>>
>> What do you think about these modifications?  The code is quite similar to
>> what was in the _ocp_softreset() function, so just moved it into a
>> function.  Also moved the callsite from the end of _enable_sysc() to the
>> beginning, which makes more sense to me, but would like to get your
>> opinion.
>
> FYI, after some more testing with this patch, I noticed that this patch
> (and the original from Tero) cause some sluggishness on UART1 console my
> 37xx/EVM platform as soon as off-mode is enabled (even without the UART
> autosuspend timeouts enabled.)  I don't see this on any other OMAP3
> platform but all the others I have have UART3 console (in PER), the EVM
> is the only one with UART1 console (in CORE.)
>
> I haven't debugged this any furhter, but thought it should be reported
> before this gets merged.
>
Trying to shoot in the dark but the UART sluggishness I observed in the
past on OMAP4 was due to improper setting of sysconfig which is
what $subject + Tero's patch is dealing with. Good to check the
value of UART sysconfig before and after the offmode entry to
see if the smart-idle/smart-idle wakeup setting getting disturbed
for some reason.

Below is the OMAP4 commit am referring to.

commit 5ae256dcd91bf308826a4ac19598b27ebb86a536
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date:   Fri Apr 13 23:25:04 2012 +0530

     ARM: OMAP: serial: Fix the ocp smart idlemode handling bug

Regards,
Santosh
