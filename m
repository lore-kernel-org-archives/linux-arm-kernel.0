From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 03 Oct 2014 15:18:24 -0700
Subject: [PATCH to be tested] serial: msm_serial: add missing sysrq
 handling
In-Reply-To: <542F167D.2020302@codeaurora.org>
References: <53E2C573.7090709@gmail.com> <53EAB01B.5030102@codeaurora.org>
 <53EC1FEA.5070907@gmail.com> <53EC220D.5050908@gmail.com>
 <542F167D.2020302@codeaurora.org>
Message-ID: <542F20B0.9020807@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/3/2014 2:34 PM, Stephen Boyd wrote:
> Hi Frank,
> 
> On 08/13/14 19:42, Frank Rowand wrote:
>> On 8/13/2014 7:33 PM, Frank Rowand wrote:
>>> On 8/12/2014 5:23 PM, Stephen Boyd wrote:
>>>> On 08/06/14 17:16, Frank Rowand wrote:
>> < snip >
>>  
>>> The patches you sent are a little hard to read since they modify further code
>>> that my patch modified.  So I have redone your patches, as if my patch was
>>> not previously applied.  Hopefully I did not make any mistakes there.  I will
>>> reply to this email with each of your redone patches.
>> Stephen's patch alternative number 2:
> 
> I had a discussion with the hardware engineer. Apparently the break bit
> in the SR register is not "sticky" so it doesn't always stay set when
> the handle_rx_dm() function runs and a break has entered the fifo. I
> used your debug patches to confirm this (I never see the break status
> bit when the fifo has multiple characters in it). It sounds like this
> bit can't really be used reliably. The recommendation is to use either
> the break start or break stop interrupt to detect when a break has
> occurred and then search the fifo for the break character (an all zero
> character). If there are two such characters then we can't be certain
> when the break was, but the chances of this seem really slim considering
> that the stale timeout probably triggers first before a human can type a
> character after the break.

That sounds good to me.

> On 1.4 hardware we can change the mode to be single character and then
> we can reliably detect the break character because only one character
> enters the fifo and the higher bits of the fifo can be used to detect if
> it is a break or not. Making that change is probably not that hard, I
> believe we can reuse all the handle_rx_dm logic and force single
> character mode on consoles, but 1.3 hardware doesn't benefit from this
> change. I'll try to get something together soon that tries to make this
> all work as best as it can.

Thanks!  I'll be glad to review and test.  And whatever else I can do to
help.

-Frank
