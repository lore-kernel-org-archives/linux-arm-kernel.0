From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 15:25:06 -0500
Subject: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
In-Reply-To: <20180524181834.GF4828@sirena.org.uk>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
 <20180524181834.GF4828@sirena.org.uk>
Message-ID: <CAL_Jsq+xHbW8S4ZMsZp8BJ=wq=t6z2gGTacBnYGgkgBG0dVdYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 1:18 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
>
>> Subsystems or drivers may opt-in to this behavior by calling
>> driver_deferred_probe_check_init_done() instead of just returning
>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>> config to decide whether to continue to defer probe or not.
>
> Should userspace have some involvement in this decision?  It knows if
> it's got any intention of loading modules for example.  Kernel config
> checks might be good enough, though it's going to be a pain to work out
> if the relevant driver is built as a module for example.

I looked into whether we could hook into uevents in some way. If we
knew when all the coldplug events had been handled, that would be
sufficient. But it doesn't look to me like we can tell when that
happens with the uevent netlink socket. I think about the only thing
we can tell is if userspace has opened a socket. I'm not all that
familiar with how the whole sequence works, so other opinions on this
would be helpful.

Also, for this to work with serial consoles, we have to make the
decision before we get to userspace. I couldn't get systemd to create
serial gettys either if we deferred later. There's some dependence on
/dev/console, but I didn't get to the bottom of it.

Rob
