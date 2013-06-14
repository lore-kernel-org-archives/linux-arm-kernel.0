From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 14 Jun 2013 10:03:45 +0800
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <Pine.LNX.4.44L0.1306131035080.1561-100000@iolanthe.rowland.org>
References: <CACVXFVP__N9o3xRMd5+sk5T0zeGcrSk41rxY6Tzi1AM-mHL81Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1306131035080.1561-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVMqboJ7zSDLx8StN27pwqEd=3BMhwRaCGPur5Nk02sjOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 10:54 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Maybe we should simply copy what the networking people do.  They are
> very concerned about performance and latency; whatever technique they
> use should be good for USB too.

Most of net devices don't use interrupt threaded handler, looks we need to
copy that first, :-)

$git grep -n request_threaded_irq drivers/net/ | wc -l
9

$git grep -n request_threaded_irq drivers/net/wireless | wc -l
5

Also 5 of 9 using interrupt threaded handler are wireless network devices, which
are a bit slow, and only one ethernet driver uses it.

So I plan to use tasklet first, then we can switch to interrupt threaded handler
in the future if mass storage devices are OK with it.

If no one objects to use tasklet, I will post out the v1 patch for review later.

Thanks,
--
Ming Lei
