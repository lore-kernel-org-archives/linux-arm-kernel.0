From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 21:35:35 +0000
Subject: [PATCH v3 10/24] drm/i2c: tda998x: don't read write-only registers
In-Reply-To: <20140119195842.24c40e22@armhf>
References: <cover.1390153344.git.moinejf@free.fr>
 <20140119195842.24c40e22@armhf>
Message-ID: <20140122213535.GI15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 07:58:42PM +0100, Jean-Francois Moine wrote:
> This patch takes care of the write-only registers of the tda998x.
> 
> The value 'MAT_CONTRL_MAT_SC(1)' in the register MAT_CONTRL has been
> set as it is at reset time.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> v3
>     - remarks from Russell King
> 	- don't move the sync polarity setting after the setting of the
> 	  register TBG_CNTRL_0 which must be the last setting of the
> 	  init sequence

This is better, except I find that there's an additional change in this
version which wasn't in the original patch 9:

>  	/* must be last register set: */
> -	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
> +	reg_write(priv, REG_TBG_CNTRL_0, 0);

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
