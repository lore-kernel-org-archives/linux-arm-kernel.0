From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 23 Dec 2016 08:20:26 +0100
Subject: [PATCH] serial: 8250: use initializer instead of memset to clear
 local struct
In-Reply-To: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com>
References: <1482463308-28968-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161223072026.GA23895@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2016 at 12:21:48PM +0900, Masahiro Yamada wrote:
> Leave the way of zero-out to the compiler's decision; the compiler
> may know a more optimized way than calling memset().

But no, it doesn't, it will leave "blank" areas in the structure with
bad data in it, which is why we do memset.  See the tree-wide fixups we
made about a year ago for this very issue.  Are you sure none of these
structures get copied to userspace?

> It may end up with memset() for big structures like this after all,
> but the code will be cleaner at least.

Please leave it as-is, unless you see a measured speedup.

thanks,

greg k-h
