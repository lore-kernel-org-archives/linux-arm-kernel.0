From: monstr@monstr.eu (Michal Simek)
Date: Thu, 10 Apr 2014 12:09:03 +0200
Subject: [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
In-Reply-To: <20140410090246.GC29093@pd.tnic>
References: <1393770760-32550-1-git-send-email-punnaia@xilinx.com>
 <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
 <20140409113246.GA8778@pd.tnic>
 <CAL_Jsq+gszc+R_BrLtHKEBGYd=3T+sE1d+-HoF9aYZt6C2k5-g@mail.gmail.com>
 <20140409151932.GK6529@pd.tnic>
 <CAHLkNHJTA5bGD1zAfzE2JrDFAWvmgYyYjir+4vR-d9Fe2-E48g@mail.gmail.com>
 <20140409174701.GO6529@pd.tnic> <53463641.1030800@monstr.eu>
 <20140410090246.GC29093@pd.tnic>
Message-ID: <53466DBF.7030606@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

>> My question is if using printk in IRQ handler and report problem is
>> equal to reporting this via edac interface. Or it is just easy way
>> to do but using edac interface is right solution and how to do it
>> properly is different question.
> 
> Yeah, it would probably be easier if you would point out first what you
> want to use the edac interface for and we can tell you whether it's
> already there/doable/makes sense, etc.

OK. This is the v1 that's why we are having this discussion now
and I really appreciate your recommendation.
It wasn't too complicated to create this driver that's why not big deal
and it is always better to talk about the code and how to handle it properly.

I had a call with Punnaiah regarding this L2 edac driver and please
correct me if my understanding of pl310 parity error
is wrong (I didn't read pl310 specification).
There are 2 memories in pl310 - data and tag,
Through controller we are able to detect 2 errors:
data parity error and tag parity error.
Both of them are uncorrectable errors and could be just reported.
L2 contains data and instructions together that's why error can
happen in data or instruction part.

The question here is.
This driver is just reporting problem through edac interface
which is counting that errors and provide an unified way
how to report problems.

Maybe as you said we don't need to use edac interface at all
but by design because every error means that there is the problem and
error should be reported and system should be reset because we just
don't know where the problem is. We know that we have a problem.

The question also is if we should execute any code because the problem
can be with instructions and system should just reset.

Isn't there any security issue that even executing any code is a problem?

>From the code I see that IRQ can be raised also for different things
because only errors are handled here (BTW: IRQ_HANDLED should be return when
IRQ is actually handled).

I just want to make sure that edac is right interface, we have right reactions
and this is how to handle this problem.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/d727dd32/attachment-0001.sig>
