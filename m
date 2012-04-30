From: mark.asselstine@windriver.com (Mark Asselstine)
Date: Mon, 30 Apr 2012 13:26:22 -0400
Subject: [PATCH] ARM:mfd: fix ezx-pcap build failure
In-Reply-To: <20120427180235.GA19778@sirena.org.uk>
References: <1335366163-12920-1-git-send-email-mark.asselstine@windriver.com>
 <2732324.Os5djSkuuZ@yow-masselst-d1> <20120427180235.GA19778@sirena.org.uk>
Message-ID: <2435660.8EsSVMd2ha@yow-masselst-d1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On April 27, 2012 19:02:35 Mark Brown wrote:
> On Fri, Apr 27, 2012 at 11:28:28AM -0400, Mark Asselstine wrote:
> > On April 26, 2012 22:52:58 Russell King - ARM Linux wrote:
> > > What is the effect when the supplied IRQ does not have a mapping to
> > > a
> > > GPIO - or it _does_ by way of a badly coded irq_to_gpio() function
> > > but that GPIO is not the correct one.
> > > 
> > > There is no prevention against endlessly looping, so it could cause
> > > a
> > > system lockup.
> > 
> > Unfortunately the commit [b1148fd4 mfd: fix pcap irq bottom handler
> > ] which modified things to loop as long as the interrupt is asserted
> > didn't supply much information regarding the behavior they were trying
> > to achieve/fix nor what would be the consequence of bailing earlier.
> 
> The usual reason for this pattern is to simulate level triggered IRQs on
> an edge triggered interrupt controller.

Makes sense. OK. I want to help here with a complete fix but it has been a 
while since I have waded into SPI and ARM initialization so here are some 
stumbling blocks for me.

If I first fix the build issue by adding 'int gpio_num' to the 
pcap_platform_data and made use of pdata->gpio_num in place of irq_to_gpio() 
in pcap_isr_work().  Now to set gpio_num.

In the board .c file I would assume the goal would be to create the necessary 
structs to set gpio_num for "ezx-pcap" and pass them to 
spi_register_board_info(). Right? But should I expect to already see some of 
this infrastructure in place already? Doesn't the "ezx-pcap" device already 
have to be defined somewhere, to have irq_base set for example? Or is this 
coming from firmware?

Thanks,
Mark A.
