From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 02 Dec 2014 16:12:48 +0100
Subject: [PATCH 3/4] devicetree: bindings: Add defeature-repeated-start
 property for Cadence I2C
In-Reply-To: <20141202141548.GA5883@katana>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
 <1417514749-24319-4-git-send-email-harinik@xilinx.com>
 <20141202111907.GC23671@leverpostej>
 <CAFcVECLtPx6shBXJbg9Uf_8fnhkMoO1zpoxGcdda7PSA7z_2rA@mail.gmail.com>
 <20141202125203.GA4072@katana>
 <CAFcVECJwFoFd6GrmF282CG+fELnYb=FNCTDq=RYKky_dHha=Jg@mail.gmail.com>
 <20141202131611.GC4072@katana>
 <CAFcVECKMqACtumHZGHbToUUSjd_dWCcLbu=_ZjNnnGdAZQ_3fg@mail.gmail.com>
 <20141202141548.GA5883@katana>
Message-ID: <547DD6F0.6060006@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2014 03:15 PM, Wolfram Sang wrote:
>>> What do you do when disable repeated start? Sending STOP and START? If
>>> so, this is really something different than repeated start. By using
>>> I2C_FUNC_I2C a user expects repeated start, so if the HW does not
>>> support it, we should say so and don't try to emulate it with something
>>> different.
>>
>> Yes, we send stop.
>
> As said before, this is wrong. Another master could interfere between
> the messages when using stop+start. This is no replacement for repeated
> start.

More importantly a lot of I2C slaves also reset their internal state machine 
on a stop. So e.g. if reading a register is implemented by doing 
start,write,repeated start,read,stop and you replace that with 
start,write,stop,start,read,stop you'll always read register zero instead of 
the register you wanted to read.

- Lars
