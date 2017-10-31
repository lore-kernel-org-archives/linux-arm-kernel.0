From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 31 Oct 2017 11:20:30 -0500
Subject: [PATCH V4 08/12] boot_constraint: Manage deferrable constraints
In-Reply-To: <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
 <88c7a0a6421d267c118f501ea1e920b04649002d.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <CAL_Jsq+_pe959RLxhGaMkG7HQABeZ2sLF2S5RByePCF9sd9vXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 8:48 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> It is possible that some of the resources aren't available at the time
> constraints are getting set and the boot constraints core will return
> -EPROBE_DEFER for them. In order to retry adding the constraints at a
> later point of time (after the resource is added and before any of its
> users come up), this patch proposes two things:
>
> - Each constraint is represented by a virtual platform device, so that
>   it is re-probed again until the time all the dependencies aren't met.
>   The platform device is removed along with the constraint, with help of
>   the free_resources() callback.
>
> - Enable early defer probing support by calling
>   driver_enable_deferred_probe(), so that the core retries probing
>   deferred devices every time any device is bound to a driver. This
>   makes sure that the constraint is set before any of the users of the
>   resources come up.

What is the effect on boot time? It's highly platform dependent, but
the worst case could be pretty bad I think.

I don't see how this handles the case you mentioned where the amba
pclk gets disabled. It only works if the constraint device is added
before any others, but that is done with initcall level games.

Rob
