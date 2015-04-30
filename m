From: lho@apm.com (Loc Ho)
Date: Thu, 30 Apr 2015 09:57:46 -0700
Subject: [PATCH v7 3/5] Documentation: Add documentation for the APM
 X-Gene SoC EDAC DTS binding
In-Reply-To: <20150430130028.GF3488@pd.tnic>
References: <1430259045-19012-1-git-send-email-lho@apm.com>
 <7128860.xHITr0VFap@wuerfel> <20150430094134.GD3488@pd.tnic>
 <10227049.9i19zDi2y3@wuerfel> <20150430130028.GF3488@pd.tnic>
Message-ID: <CAPw-ZTnuyB2ne1C2-38qAxM_ANwdr9nuCYUMj=aTx7c90sVg+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> I've looked at the driver in a little more detail now, and found that
>> it is a weird conglomerate at the moment. Basically you have four
>> drivers in one file here, appended to one another, but not sharing
>> any common functions except the module_init() that registers the four
>> drivers. This is what Rob was referring to when he suggested splitting
>> it up into four files, and these would in total be smaller than the
>> common file (by being able to use module_platform_driver()).
>>
>> However, there is another dimension to this, which supports your point
>> about making it one driver for the platform: The split into four drivers
>> is completely artificial, because all four use the same IRQs and
>> implement four separate interrupt handlers for it (using IRQF_SHARED),
>> each handling only the events they are interested in. Similarly, they
>> all access the same register set ("pcperror"), aside from having their
>> own separate registers, and they use the "syscon" framework to get to
>> the registers.  This seems to be an inferior design, as the pcperror
>
> Doh, now that you mention it...
>
> So why isn't this thing registering a single IRQ handler which
> multiplexes between the _check routines depending on the bits set in
> PCPHPERRINTSTS/MEMERRINTSTS? (L3 alternatively, ctx->dev_csr + L3C_ESR).
>
> This would really make it a single driver which acts according to the
> bits set in those error registers. It can't get any simpler than that.
>
> Loc?

I had read all the emails interaction. Yes I can write a single EDAC
driver. But I actually have multiple instances and single instance of
the same IP's. For example, I have 4 DDR controllers, 4 CPU domains,
one L3 and one SoC. If you can suggest to me how this would work with
devicetree, I might be able to make it works. But from HW point of
view (take the memory controller as an example), there is really 4
hardware blocks and some shared IP's block for status. It is much
simple representation with multiple instance of the driver. In
addition, should one day we have 6 memory controllers, I would just
add two more instances in the DT node.

I think we should first agreed on the DT binding and let's not worry
about APEI. Then, whether we have one file or multiple file. Again,
the HW consist of:

1. One top level interrupt and status registers
2. CSW, MCB A and MCB B for detection of any active memory controllers
3. 4 individual memory controller instance
4. 4 CPU domain instance with its own individual L2 registers
5. Each CPU has instance own L1
6. One L3 instance
7. One SoC instance

As for as what is useful, we find that the memory controller and the
L1 and L2 are useful as it provides info for errors - for HW/system
debugging as well as margin of DDR.

-Loc
