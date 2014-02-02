From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Feb 2014 16:23:09 +0000
Subject: [PATCH v5 09/23] drm/i2c: tda998x: don't read write-only registers
In-Reply-To: <5269e596e16dfe40253dce38ceb0dc4a617384c1.1390986083.git.moinejf@free.fr>
References: <cover.1390986082.git.moinejf@free.fr>
 <5269e596e16dfe40253dce38ceb0dc4a617384c1.1390986083.git.moinejf@free.fr>
Message-ID: <20140202162309.GF26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 25, 2014 at 06:14:42PM +0100, Jean-Francois Moine wrote:
> This patch takes care of the write-only registers of the tda998x.
> 
> The registers SOFTRESET, TBG_CNTRL_0 and TBG_CNTRL_1 have all bits
> cleared after reset, so, they may be fully re-written.
> 
> The register MAT_CONTRL is set to
> 	MAT_CONTRL_MAT_BP | MAT_CONTRL_MAT_SC(1)
> after reset, so, it may be fully set again to this value.

I said in v3 of this patch, which seems to remain unaddressed:

>       /* must be last register set: */
> -     reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
> +     reg_write(priv, REG_TBG_CNTRL_0, 0);

Register changes which have a potential effect shouldn't be part of a
patch which is really only trying to avoid reading from write only
registers.

This could be a potential functional change - and it's probably one
which Rob Clark should at least be made aware of.  As I commented last
time, when you're changing register values in an otherwise innocuous
patch, you should comment about them in the patch description.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
