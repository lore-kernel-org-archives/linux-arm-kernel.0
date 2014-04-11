From: bp@alien8.de (Borislav Petkov)
Date: Fri, 11 Apr 2014 15:14:42 +0200
Subject: [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
In-Reply-To: <53466DBF.7030606@monstr.eu>
References: <1393770760-32550-1-git-send-email-punnaia@xilinx.com>
 <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
 <20140409113246.GA8778@pd.tnic>
 <CAL_Jsq+gszc+R_BrLtHKEBGYd=3T+sE1d+-HoF9aYZt6C2k5-g@mail.gmail.com>
 <20140409151932.GK6529@pd.tnic>
 <CAHLkNHJTA5bGD1zAfzE2JrDFAWvmgYyYjir+4vR-d9Fe2-E48g@mail.gmail.com>
 <20140409174701.GO6529@pd.tnic> <53463641.1030800@monstr.eu>
 <20140410090246.GC29093@pd.tnic> <53466DBF.7030606@monstr.eu>
Message-ID: <20140411131442.GA11636@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 12:09:03PM +0200, Michal Simek wrote:
> The question here is. This driver is just reporting problem through
> edac interface which is counting that errors and provide an unified
> way how to report problems.

Yes, normally you can use edac for reporting and error counting. But,
if, as I said earlier, it is easier to solve your issue of having two
entities touch one hardware and synchronizing around it is too much,
just for this one case, you can simply report the errors with simple
printk, without the edac interface.

This is why I was asking the practical question of why do you even need
the edac interface? If it is only for reporting, use printk and solve
the problem of having two drivers.

> Maybe as you said we don't need to use edac interface at all but by
> design because every error means that there is the problem and error
> should be reported and system should be reset because we just don't
> know where the problem is. We know that we have a problem.
>
> The question also is if we should execute any code because the problem
> can be with instructions and system should just reset.
>
> Isn't there any security issue that even executing any code is a
> problem?

Well, this is up to you to answer. If an UE (Uncorrectable Error) causes
data to get corrupted on your system, which, as a result, corrupts
visible state which lands on storage, you definitely want to stop
executing any code. x86 deals very rigorously with errors like those
by running an exception handler, on AMD there's also this thing called
syncflood which stops any execution and a warm reset happens.

So you have to think hard what those UEs cause on your systems and only
then act accordingly. If something bad like the above happens, the last
thing you want to do is report them to dmesg.

HTH.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
