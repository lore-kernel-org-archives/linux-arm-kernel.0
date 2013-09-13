From: shijie8@gmail.com (Huang Shijie)
Date: Fri, 13 Sep 2013 00:12:14 -0400
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <1378999322.4210.95.camel@i7.infradead.org>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com>
 <1378999322.4210.95.camel@i7.infradead.org>
Message-ID: <20130913041208.GD3051@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 04:22:02PM +0100, David Woodhouse wrote:
> On Thu, 2013-09-12 at 22:58 -0400, Huang Shijie wrote:
> > 
> > But for the quadspi driver, it does not need this information.
> > 
> > When the drivers knows that it is a Quad-read transaction, it will uses
> > the relative LUT sequence which uses the 4 lines.
> 
> But the controller driver shouldn't *have* that incestuous knowledge of
> the command set of the chip that happens to be connected to it.

I think the controller is designed for the NOR flash, yes, a little
strange.

> 
> That's what we're *complaining* about.
> 
> It *should* "need this information", and should just do what it's *told*
> to do by the slave device driver.
I can add the lines info in the m25p80_read() for the quad-read, but the lines
information is redundant to this Quadspi driver. 

I will send you the datasheet tomorrow.

Mark and you want to create the LUT instruction sequence at the runtime,
But there is some disadvantage if we do so:
  [1] low efficiency: 
      If you want to change the LUT regitster, you should unlock the LUT
      register, and change the LUT regitsters, and lock the LUT
      regitsters again.

  [2] we may can not create all the LUT instruction sequence at the
      runtime. For example, the buffer program(OPCODE_PP):
      the m25p80_write() may write 256bytes at a time, but the Quadspi
      controller only has a 64-byte TX-FIFO, so the controller should
      write a 64bytes firstly, then sends to the NOR with a read-status
      command. Do you want to create a read-status LUT instruction 
      sequence at run time? This is not good solution, we should
      pre-populate the read-status LUT information.

  [3] We may can not create the LUT instruction sequence at the runtime,
      since we can not get enough information from the spi_transfer{}.
      A whole LUT instruction sequence may needs the following info:
       1.) spi command.
       2.) lines info: single line, dual lines, quad lines.
       3.) Address width: 3 bytes address or 4 bytes address.
       4.) instruction type: Read or write or other. 
       5.) length info: how many bytes for this transaction .
       6.) dummy info: how many dummy is needed for this transaction.

      We can not get the dummy info from the spi_transfer{} 

      I may still miss something. But If we want to create a LUT
      instruction sequence at the runtime, we should _PARSE_ out the SPI
      NOR command firstly. If we parse out the SPI nor commands, there
      is no difference between the pre-populete-LUT and
      create-LUT-at-runtime.

thanks
Huang Shijie 

       
