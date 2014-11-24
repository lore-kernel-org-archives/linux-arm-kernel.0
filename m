From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Nov 2014 00:00:16 +0100
Subject: [PATCH] of: support passing console options with stdout-path
In-Reply-To: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
References: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20141124230016.GP20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 10:23:58PM +0000, Leif Lindholm wrote:
> Support specifying console options (like with console=ttyXN,<options>)
> by appending them to the stdout-path property after a separating ':'.
> 
> Example:
> 	stdout-path = "uart0:115200";
> 
> This patch also modifies of_find_node_by_path() to match only the
> portion of the path before a ':'.

Hi Leif

These appears to somewhat conform to ePAPR, which says:

      A string that specifies the full path to the node representing
      the device to be used for boot console output. If the character
      ":" is present in the value it terminates the path.

So you can put any random junk after the :. However, are we going to
have backward/forward compatibility problems, and problems with
bootloaders? The current kernel code does not look for the :. So a new
DT blob on an old kernel will not work so well.

More worrying, barebox does not support the : either. So there is a
danger your bootloader suddenly goes silent after a dt blob update.

Would it be safer to add a new property in chosen?

      Andrew
