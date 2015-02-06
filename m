From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Feb 2015 20:27:44 -0800
Subject: [PATCH v4 02/10] mtd: st_spi_fsm: Fetch boot device locations
 from DT match tables
In-Reply-To: <1421853868-8262-3-git-send-email-lee.jones@linaro.org>
References: <1421853868-8262-1-git-send-email-lee.jones@linaro.org>
 <1421853868-8262-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20150206042744.GK18140@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 03:24:20PM +0000, Lee Jones wrote:
> To trim down on the amount of properties used by this driver and to conform
> to the newly agreed method of acquiring syscfg registers/offsets, we now
> obtain this information using match tables.

Where did this agreement happen? Are you only referring to the previous
patch?

I think I asked this previously, and I didn't get an answer.

Also, I realized that all this boot device / syscfg gymnastics is just
for one simple fact; your driver is trying to hide the fact that your
system can't reliably handle 4-byte addressing for the boot device. Even
if you try your best at toggling 4-byte addressing before/after each
read/write/erase, you still are vulnerable to power cuts during the
operation. This is a bad design, and we have consistently agreed that we
aren't going to work around that in Linux.

Better solutions: hook up a reset line to your flash; improve your boot
ROM / bootloader to handle 4-byte addressing for large flash.

What's the possibility of dropping all this 4-byte address toggling
shenanigans? This will be a blocker to merging with spi-nor.c.

> In the process we are deprecating the old generic compatible string and
> providing 3 shiny new ones for each of the support platforms.  The
> deprecated compatible string will be removed in due course.

Aren't you already removing the compatible string? (You changed this in
the latest revision.)

> Cc: devicetree at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

[snip]

Brian
