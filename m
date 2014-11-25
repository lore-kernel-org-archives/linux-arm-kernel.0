From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 25 Nov 2014 00:12:36 +0000
Subject: [PATCH] of: support passing console options with stdout-path
In-Reply-To: <20141124230016.GP20238@lunn.ch>
References: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
 <20141124230016.GP20238@lunn.ch>
Message-ID: <20141125001236.GA2361@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 12:00:16AM +0100, Andrew Lunn wrote:
> On Mon, Nov 24, 2014 at 10:23:58PM +0000, Leif Lindholm wrote:
> > Support specifying console options (like with console=ttyXN,<options>)
> > by appending them to the stdout-path property after a separating ':'.
> > 
> > Example:
> > 	stdout-path = "uart0:115200";
> > 
> > This patch also modifies of_find_node_by_path() to match only the
> > portion of the path before a ':'.
> 
> Hi Leif
> 
> These appears to somewhat conform to ePAPR, which says:
> 
>       A string that specifies the full path to the node representing
>       the device to be used for boot console output. If the character
>       ":" is present in the value it terminates the path.
> 
> So you can put any random junk after the :. However, are we going to
> have backward/forward compatibility problems, and problems with
> bootloaders? The current kernel code does not look for the :. So a new
> DT blob on an old kernel will not work so well.

I _think_ this will be less of a problem in practice than it could be
in theory.

The reason this is needed is that at least several platforms have
different baudrate settings in firmware than the default provided by
the kernel for their UART. As a result, stdout-path becomes
semi-useless; the only thing it gives you is the ability to get
earlycon output without specifying a specific device (and then the
console turns to garbage once non-earlycon is enabled).

Hence, a platform that gets along happily today without the ability to
specify console options in stdout-path would have no pressing need to
add it to its dt. This should permit at least a very long, soft,
transition path.

(console= on kernel command line continues to override stdout-path.)

> More worrying, barebox does not support the : either. So there is a
> danger your bootloader suddenly goes silent after a dt blob update.

_That_ would be most unfortunate.

> Would it be safer to add a new property in chosen?

My preference would be not, given the above, but the important thing
is to get the functionality in so we get rid of mandatory console=.

/
    Leif
