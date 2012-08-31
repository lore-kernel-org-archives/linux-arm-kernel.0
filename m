From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 31 Aug 2012 10:15:09 +0300
Subject: [PATCH v4 2/3] ARM: omap: hwmod: get rid of all
 omap_clk_get_by_name usage
In-Reply-To: <5040586D.2020406@ti.com>
References: <1346230576-20004-1-git-send-email-rnayak@ti.com>
 <1346230576-20004-3-git-send-email-rnayak@ti.com>
 <CAJOA=zM2sFsrdohooKp1+zsV_AK6dKnoN37+Gs2oskBUK4J00w@mail.gmail.com>
 <503F26A4.3050902@ti.com> <503F5517.4010100@ti.com>
 <1346344933.2327.43.camel@deskari> <5040586D.2020406@ti.com>
Message-ID: <1346397309.18766.5.camel@lappyti>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-31 at 11:53 +0530, Archit Taneja wrote:

> The only little problem was that during bootup, when hwmods are setup, 
> only the 'parent' hwmod was able to get reset properly, all the other 
> 'child' hwmods don't have modulemode bits tied to them, and hence 
> weren't able to reset. So we got some error prints.
> 
> Once DSS driver kicks in, the driver ensures the parent is enabled for 
> any child to be enabled, so we don't face the issue again.
> 
> So, if DSS driver is not built in, and if the bootloader left DSS in a 
> bad state, the DSS clocks might remain messed up all the time since 
> hwmod fwk wasn't able to reset them.
> 
> I think this is why we didn't proceed with remove "dss_fck" as a slave 
> clock. If this issue is minor, we could go ahead and remove it.

I wonder if we could handle this with a custom reset function. We
already have a reset func for dss core. If I remember right, the main
point for that is the fact that omap4 doesn't have a softreset for dss
core, so we manually write the default values to registers.

For omap2/3 this would be simple: skip the resets for all other dss
submodules, and dss core's reset would enable all the clocks and set the
softreset bit. This would reset all the submodules also.

Omap4 is more tricky. I guess we'd need to enable all the clocks, clear
manually dss core's registers, and then set softreset bits in all the
submodules. So in this case dss core would need to have information
about the other submodules.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120831/33e18807/attachment-0001.sig>
