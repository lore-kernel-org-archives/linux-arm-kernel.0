From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 17 Jul 2018 13:27:51 +0100
Subject: [PATCH] arm64: cpuinfo: Include cleartext implementer and part
 strings
In-Reply-To: <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
References: <20180715035342.11371-1-olof@lixom.net>
 <f619f0e9-b8b4-29fb-5ad6-7f5ebc3a4da8@arm.com>
 <CAOesGMjq=d3ZPLTq5qudx+EE+XC2-zSsA1ViheTwM7fnTtJh2Q@mail.gmail.com>
Message-ID: <e7e272e0-a7ad-1a97-a081-acf3bfa42b6f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/18 15:34, Olof Johansson wrote:
[...]
> There's also a growing expectation of the system to behave more like
> x86, especially when it comes to trivial ways of detecting what kind
> of machine you are running on. On x86 it's been trivial to look at
> /proc/cpuinfo since it is provided by the platform there. Nobody wants
> to change their implementation from having to read a file to exec a
> program, dealing with errors, and parsing its output (sure, easier
> from scripts, but more awkward from real source).

The thing with the "be more like x86" argument is that it never actually 
stands up to scrutiny. What is proposed here (again) is for the kernel 
to decode the raw MIDR description of the *CPU core microarchitecture* 
to a human-readable string. What does the nearest Intel box say about 
its microarchitecture name?

cpu family	: 6
model		: 79

OK, I had to go and look up that that apparently implies "Broadwell", so 
the x86 kernel is in fact no more helpful in that regard than arm64.

Furthermore, telling the user that they have have 4 "Cortex-A53" cores 
vs. 4 "part: 0xd03" cores doesn't actually give them any more meaningful 
information about their *system*, because that example reflects about 
half the low-to-mid-range SoCs on the market today. What the "model 
name" on x86 describes is a specific processor SKU, of which Arm has no 
*architectural* equivalent, for reasons which should hopefully be 
obvious from the fundamental differences in the business models driving 
the respective architectures.

And yet whenever /proc/cpuinfo/ comes up, nobody ever seems to ask for 
some kind of SoC identifier in there; it's always just decoding MIDR 
into a microarchitecture name, which implies that all these people want 
is to see a string for the sake of seeing a string, regardless of how 
meaningful it actually might be (and yes, I do realise that in *some* 
cases a CPU core is essentially unique to a particular SoC, but we have 
to look at the big picture here).

In summary; when a small minority of users are complaining that oranges 
aren't apples, the sensible response is not to start debating whether to 
paint the oranges green or red.

Robin.
