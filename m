From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jan 2014 09:45:52 +0100
Subject: [PATCH 2/2] serial: fsl_lpuart: add eDMA support
In-Reply-To: <1d437762499348b6aeca3621b151d770@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
 <201401090956.38789.arnd@arndb.de>
 <1d437762499348b6aeca3621b151d770@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <201401130945.53447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 January 2014, Yao Yuan wrote:
> I need the functions like this:
> Static A()
> {
>         if(condition) 
>                 B();
> }
> Static B()
> {
>         callback:C();
> }
> Static C()
> {
>         if(condition)
>                 A();
> }
> 
> So, it's hard to avoid forward declarations for "static" functions.
> I'm very glad for a better way.


Ok, that makes sense. It is an unusual pattern from the dmaengine API,
most drivers can more easily do without forward declarations. I think
you'd be able to avoid the lpuart_prepare_tx() forward declation, but
that wouldn't actually improve readability in this case. Just add a
comment above the declarations describing that they are needed for the
callbacks and that no recursion is possible. The important problem
to avoid really is having unbounded recursion between multple
functions, because that could blow the kernel stack size limit.

A small improvement that you can try is to have forward declarations
for the completion functions rather than the dma start functions, but
it won't be a big difference in the end. Your choice.

	Arnd
