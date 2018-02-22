From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 Feb 2018 00:34:57 +0100
Subject: [v2,1/1] ARM: orion5x: use mac_pton() helper
In-Reply-To: <bce65520-7f11-49f5-c806-59e508001321@the2masters.de>
References: <1443795153-40836-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <099870d3-e2bd-aad9-d526-5438596bb575@the2masters.de>
 <20180222214237.GH28112@lunn.ch>
 <bce65520-7f11-49f5-c806-59e508001321@the2masters.de>
Message-ID: <20180222233457.GA6052@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But: On the 27th block is a large file (1,5kB) without 0 bytes inside.
> The code in qnap_tsx09_find_mac_addr() maps 1kB into memory (not a whole
> file or the whole 384kB) and then calls qnap_tsx09_check_mac_addr() ->
> mac_pton() -> strlen() on this memory block. as there is no 0 byte in the
> file on the 27th block, strlen runs into bad memory and the machine panics.
> The old code had no strlen().

Yes, that sounds look a good explanation. 

> I changed mac_pton() to use strnlen(), and now the panic is gone. I don't
> know why strlen is actually needed in mac_pton. The string is checked in the
> following loop, if there is a zero byte somewhere, the loop will be returned
> immediately. So I think the strlen() superfluous. Is the following patch
> correct?

The patch has been corrupted by you email client. But otherwise, yes.

Please take a look at:

https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html

It will give you hits about correctly formatting the patch. In
addition it should have:

Fixes: 4cd5773a2ae6 ("net: core: move mac_pton() to lib/net_utils.c")

before the --- line, to indicate what it is fixing.

This patch should be against
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git,
since it is a fix, and sent to <netdev@vger.kernel.org>.

Thanks
      Andrew
