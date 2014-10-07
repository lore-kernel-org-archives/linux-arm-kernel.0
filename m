From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Oct 2014 11:18:32 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <871tqkc1pn.fsf@free.fr>
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <6310030.SmNYckCtJ4@wuerfel> <871tqkc1pn.fsf@free.fr>
Message-ID: <7809732.cy12qq1fce@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 October 2014 23:44:52 Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Monday 06 October 2014 16:02:09 Andrew Ruder wrote:
> >> On Mon, Oct 06, 2014 at 09:29:36PM +0200, Robert Jarzmik wrote:
> >> > Actually, I have a question for Andrew : was your commit aimed at the 3 or 4
> >> > available UARTs (ie. in peripheral address space), or is it a case where an
> >> > external UART is mapped on the system bus (if that is possible) ?
> >> 
> >> My apologies!  I'm actually on a really long-term project of getting my
> >> board (similar to zeus board already in the kernel) fully running off of
> >> devicetree.  For this particular board, all of the UARTS are on the
> >> system bus and not the built in ones.  But yes - I do see how the
> >> built-in UARTS would overlap and hit the BUG_ON on other boards.  Any
> >> thoughts on a better way of solving this than just reverting the patch
> >> back into only working on the built-in UARTs?
> >
> > I think the best way forward is to make the built-in UARTs work with
> > debug_ll_io_init and then apply your patch again.
> Yes, and that means revert, right ?
> 
> The best approach I'd see for pxa_map_io() would be to call debug_ll_io_init()
> conditionally, when the CONFIG_DEBUG_UART_PHYS is defined and is not within the
> peripheral bus range, ie. within [ PERIPH_PHYS .. PERIPH_PHYS + PERIPH_SIZE ].
> 
> I don't see how to do it without ugly ifdefery though such as :
> #if defined(CONFIG_DEBUG_UART_PHYS) && \
>     ((CONFIG_DEBUG_UART_PHYS < PERIPH_PHYS) || (CONFIG_DEBUG_UART_PHYS >=
>     PERIPH_PHYS + PERIPH_SIZE))
>     debug_ll_io_init();
> #endif
> 
> But that's awfull, there should be another better way ...

Can't you just define CONFIG_DEBUG_UART_VIRT outside of the existing
mappings? It doesn't have to use the same mapping as PERIPH_PHYS.

	Arnd
