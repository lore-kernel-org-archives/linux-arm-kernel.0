From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 4 Sep 2014 09:45:36 -0700
Subject: [PATCH 2/3] gpio: zynq: Fixed broken wakeup implementation
In-Reply-To: <CACRpkdbb0oeA0b5SSLtR6U7jv8asCeEJdHEsDAg7_tH+GHc5RQ@mail.gmail.com>
References: <1409335127-26712-1-git-send-email-soren.brinkmann@xilinx.com>
 <1409335127-26712-3-git-send-email-soren.brinkmann@xilinx.com>
 <CACRpkdbb0oeA0b5SSLtR6U7jv8asCeEJdHEsDAg7_tH+GHc5RQ@mail.gmail.com>
Message-ID: <00af0950-9750-4c5c-97ee-76893823c29d@BN1BFFO11FD020.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-09-04 at 06:27PM +0200, Linus Walleij wrote:
> On Fri, Aug 29, 2014 at 7:58 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> 
> > From: Ezra Savard <ezra.savard@xilinx.com>
> >
> > Use of unmask/mask in set_wake was an incorrect implementation. The new
> > implementation correctly sets wakeup for the gpio chip's IRQ so the gpio chip
> > will not sleep while wakeup-enabled gpio are in use.
> >
> > Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
> > Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> Patch applied.
> 
> However the problems seems quite generic.
> 
> Do you see this kind of error in other GPIO drivers?
> 
> IRQchip semantics always make me nervous.

Our implementation was just completely flawed. It did work with our
limited tests using the sysfs interface. But once we started with the
gpio_keys things fell apart. The set_wake did mask/unmask IRQs, which
is clearly the job of the respective mask/unmask function of a gpiochip.
After we found that, we looked at a few other drivers and designed this
following gpio-mxs.
So, the core part was to do the right thing in set_wake. Once that was
done, the runtime PM callbacks needed some realignment to determine
whether GPIO is a wakeup device or not.

So, this was really just a gpio-zynq problem, not really generic.

Thanks for applying. I'll post the gpiolib-sysfs patch on its own in a
separate submission.

	S?ren
