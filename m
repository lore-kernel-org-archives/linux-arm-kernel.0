From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 1 Nov 2017 02:29:24 +0000
Subject: [PATCH V4 08/12] boot_constraint: Manage deferrable constraints
In-Reply-To: <CAL_Jsq+_pe959RLxhGaMkG7HQABeZ2sLF2S5RByePCF9sd9vXg@mail.gmail.com>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
 <CAL_Jsq+_pe959RLxhGaMkG7HQABeZ2sLF2S5RByePCF9sd9vXg@mail.gmail.com>
Message-ID: <CAKohponB0V-jNozTSo4mb0kw3BV_fBDBWLQEq5fF7WrvCvXRHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2017 at 16:20, Rob Herring <robh+dt@kernel.org> wrote:
> What is the effect on boot time? It's highly platform dependent, but
> the worst case could be pretty bad I think.

Yeah, it can increase considerably here and I have plans for that, just
that i didn't wanted to get them in the first iteration to keep things simple.

What we can (should?) do is, that the boot constraint framework can hook
into other frameworks like regulators/clk/PM, etc, so that whenever a new
clk/regulator is added to those frameworks, they check for pending
requests from boot constraint framework. If found, they can call a callback
of the boot constraint framework which will set the constraints to the resource
before anyone else gets a chance. At that point we can remove the early
defer probing support that this patch is adding. And things would be quite fast
then.

> I don't see how this handles the case you mentioned where the amba
> pclk gets disabled. It only works if the constraint device is added
> before any others, but that is done with initcall level games.

Yeah, so as I said earlier, the basic idea is that these constraints must get
set before any user driver (for constrained devices) comes up. And the
only way to do that is by making sure the constraints get added at early
initcall levels. The same is done for all the three example drivers I have
added.

The amba-pclk thing isn't a issue then, as that stuff happens only at probe
and not when the amba device is created.

--
viresh
