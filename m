From: chunfeng.yun@mediatek.com (chunfeng yun)
Date: Mon, 11 Apr 2016 15:16:08 +0800
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
In-Reply-To: <87shyspwbz.fsf@intel.com>
References: <1460106483-24793-1-git-send-email-chunfeng.yun@mediatek.com>
 <20160408140701.GA3547@kroah.com> <1460343705.10419.12.camel@mhfsdcap03>
 <87shyspwbz.fsf@intel.com>
Message-ID: <1460358968.10419.26.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-04-11 at 08:07 +0300, Felipe Balbi wrote:
> Hi,
> 
> chunfeng yun <chunfeng.yun@mediatek.com> writes:
> > On Fri, 2016-04-08 at 07:07 -0700, Greg Kroah-Hartman wrote:
> >> On Fri, Apr 08, 2016 at 05:08:03PM +0800, Chunfeng Yun wrote:
> >> > NULL pointer dereferrence will happen when class driver
> >> > wants to allocate zero length buffer and pool_max[0]
> >> > can't be used, so skip reserved pool in this case.
> >> 
> >> Why would a driver want to allocate a 0 length buffer?  What driver does
> >> this?
> > It's misc/usbtest.c
> 
> that'll do what you ask it to do with the userspace tool testusb. Are
> you trying to pass a size of 0 ?
> 
No, I just ran "testusb -t10" which called test_ctrl_queue().
In this function, sub-case 8 passed a parameter @len as 0 to
simple_alloc_urb(), and then it tried to allocate a 0-length buffer.

> >> Shouldn't we fix that issue instead?
> > I don't know which way is better, but it seems simple to fix it up in
> > buffer.c 
> 
> I think we should, really, avoid a 0-length allocation, but passing a
> size of 0 to testusb isn't very good either ;-) How are you calling
> testusb ?
> 
As explained above.
