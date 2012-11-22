From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 22 Nov 2012 15:42:14 +0200
Subject: OMAP4430 produces boot warnings
In-Reply-To: <50AE1DC0.3030002@ti.com>
References: <20121121230337.GR3332@n2100.arm.linux.org.uk>
 <50AE1DC0.3030002@ti.com>
Message-ID: <50AE2BB6.8080406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-22 14:42, Archit Taneja wrote:
> Hi,
> 
> On Thursday 22 November 2012 04:33 AM, Russell King - ARM Linux wrote:
>> This one is nice and long, from last nights boot test.  Looks like it was
>> introduced sometime in the last couple of weeks.  Full log at:
>>
>> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=518
>>
>> and config:
>> http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2786
> 
> Doing a bisect results in this commit:
> 
> commit 0c7018e232c5526869250e57da8043a86a45b5de
> Author: Rajendra Nayak <rnayak@ti.com>
> Date:   Thu Oct 18 12:20:06 2012 +0300
> 
>     ARM: OMAP4: suspend: Program all domains to retention
> 
>     Remove the FIXME's in the suspend sequence since
>     we now intend to support system level RET support.
> 
>     Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>     Signed-off-by: Tero Kristo <t-kristo@ti.com>
>     Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> I guess this commit will allow DSS to go to a lower power state. So what
> might be happening is:
> 
> - After returning back from the lower power state, the DISPC base
> address register hasn't been restored. Leading to a fetch from a bad
> address. Resulting in an OCP error.
> 
> or
> 
> -  DSS never came back to ON state, and it's not able to access
> registers. I doubt this possibility because we got an OCP error
> interrupt from DISPC.

It seems that the problem is that dispc never restores the context,
because get_ctx_loss_count always returns 1. I enabled pwrdm debug
prints, and pwrdm_get_context_loss_count() always returns 1 for dss,
even if the register contents have obviously been lost.

Does the pwrdm mistakenly think that in RET state the DSS still keeps
the register contents?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/40c241c6/attachment.sig>
