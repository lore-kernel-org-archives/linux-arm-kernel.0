From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jul 2012 06:31:53 +0000
Subject: [PATCH V2 6/7] ARM: SPEAr13xx: Add auxdata for Ethernet
 controller.
In-Reply-To: <500F770C.9000005@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
 <50068030.1050905@st.com> <500F770C.9000005@st.com>
Message-ID: <201207250631.54157.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 July 2012, deepaksi wrote:

> *But there are few catches/ query I have with me.*
> 
> 1. Within the driver space now, even if it is a stmmac_platform.c file 
> we are kind of adding
> a non driver related miscellaneous space (SoC specific) to do some 
> initializations.
> Will that be fine to do all such initializations in driver ?

It depends a lot on what you want to do with those callbacks.
We generally try hard to make those callbacks unnecessary, but
I agree that this is not always easy or obvious how to do it.

There are cases where you have one SoC doing something very
obscure with an otherwise generic piece of hardware, and in
that case, it may be better to keep a callback in platform
code and use some method (auxdata or a notifier) to hand a
pointer to the driver.

In other cases, you have a number of platforms that essentially
want to do the same thing (set up clocks or voltages, pick a
PHY, ...) and in that case you should not be using callback
functions at all but instead describe the differences in the
device tree using the bindings for whatever you want to do
(adding bindings if necessary).

You can also have a case where the callback is just doing
something that is part of that driver in different ways,
and in that case using the "compatible" property to determine
which way is right is the best option.

Can you post here the complete set of callback implementations
that you have in your development trees at the moment? That should
help us determine which case we're talking about here.

	Arnd
