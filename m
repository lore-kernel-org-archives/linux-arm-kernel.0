From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 15 Mar 2011 11:30:44 +0530
Subject: [PATCH 2/7] davinci: eliminate use of IO_ADDRESS() on sysmod
In-Reply-To: <201103141721.52033.arnd@arndb.de>
References: <1300110947-16229-1-git-send-email-manjunath.hadli@ti.com>
	<201103141721.52033.arnd@arndb.de>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C246CB1@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Mar 14, 2011 at 21:51:51, Arnd Bergmann wrote:
> On Monday 14 March 2011, Manjunath Hadli wrote:
> > Current devices.c file has a number of instances where
> > IO_ADDRESS() is used for system module register
> > access. Eliminate this in favor of a ioremap()
> > based access.
> > 
> > Consequent to this, a new global pointer davinci_sysmodbase
> > has been introduced which gets initialized during
> > the initialization of each relevant SoC
> > 
> > Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>
> 
> The change looks good, it's definitely a step in the right
> direction.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> I think you can go even further:
> 
> * A straightforward change would be to move davinci_sysmodbase
>   into a local variable of the davinci_setup_mmc function,
>   which I believe is the only user. Then you can ioremap
>   and iounmap it directly there.

This patch accesses sysmodule only in davinci_setup_mmc,
but follow-on patches use it in other places. So, this patch
sort of lays the foundation for that. This is not really
evident in this patch so the patch description should have
captured that.

> * If you need to access sysmod in multiple places, a nicer
>   way would be to make the virtual address pointer static,
>   and export the accessor functions for it, rather than
>   having a global pointer.

Seems like opinion is divided on this. A while back
I submitted a patch with such an accessor function and
was asked to do the opposite of what you are asking here.

https://patchwork.kernel.org/patch/366501/

It can be changed to the way you are asking, but would
like to know what is more universally acceptable (if
at all there is such a thing).

Thanks,
Sekhar
