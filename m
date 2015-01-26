From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 26 Jan 2015 12:38:48 +0200
Subject: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider
 infrastructure to clock driver
In-Reply-To: <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
Message-ID: <54C61938.8000303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/15 23:51, Paul Walmsley wrote:
> + Tomi 
> 
> On Thu, 27 Nov 2014, Tero Kristo wrote:
> 
>> Splits the clock provider init out of the PRM driver and moves it to
>> clock driver. This is needed so that once the PRCM drivers are separated,
>> they can logically just access the clock driver not needing to go through
>> common PRM code. This would be wrong in the case of control module for
>> example.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> This patch moves things in the wrong direction (ie, rather than keeping 
> the PRM register accesses in the PRM code, it moves PRM register accesses 
> into the clock code).  But I see that a subsequent patch in this series 
> moves them back.  So this change is temporary and that seems reasonable to 
> me.
> 
> However, as long as the clock code wants to do low-level register accesses 
> to PRM/CM/SCM registers, there needs to be some way to keep register 
> updates originating from the clock code from racing with register updates 
> coming from other code (e.g. non-clock-related PRM/CM/SCM accesses). So 
> I've changed this patch to use regmap (as below), and the followup patch 
> later in the series will be changed too.  Seems to work so far but let's 
> see how things go with the rest of the series.

I'm not sure if I miss something, but regmap_write does not protect from
problems if there are multiple users for the same registers. You need to
use regmap_update_bits() to get a protected read/write sequence, in
which you can change only the bits that you want to change.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150126/59dadd47/attachment.sig>
