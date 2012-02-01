From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Feb 2012 20:28:48 +0100
Subject: [PATCH] pinctrl: pin configuration states
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB15E@HQMAIL01.nvidia.com>
References: <1326725496-28928-1-git-send-email-linus.walleij@stericsson.com>
 <74CDBE0F657A3D45AFBB94109FB122FF1780DAB15E@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdZAofVVQ5_b_R2FUWy5AfWOge1NOuO61q7vFiLB4wUizQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 8:03 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Monday, January 16, 2012 7:52 AM:
>> This introduce a pin configuration state structure and activation
>> functions similar to the pinmux map. (etc)

>> Also there is no way for a pinmux and its associated device to
>> switch states in this solution. However one does not exclude the
>> other, we might want per-device associated pinmux and group
>> states *also*.
>
> Yes, I think per-device states are a primary use-case...

OK added this for v2.

> In the long-run for per-device states, I think you'll need the per-
> device fields that the pinmux mapping table has:
>
> ? ? ? ?struct device *dev;
> ? ? ? ?const char *dev_name;

OK fixed this.

> In that case, .apply_on_init/.apply_on_exit don't really apply that well.
> I'd suggest combining those two fields into a "bool hog" field just like
> the pinmux mapping table, and defining that .name name must be "init" or
> "exit" when .hog==true. That seems more in line with devices using the
> .name field to define which states happen when.

I don't know, it looks fragile, "hog" is not intuitive since that state is
not going to stay or be "hogged" in any way. I'm staying with the
strongly-typed bools instead of hard-coded strings FTM.

But using #defined strings has the beauty of enforcing it a bit
across platforms so I'm still considering it.

> Bikeshedding a but, the names init/fini are a slightly more match pair,
> but perhaps less understandable?

Hehe :-) a bashism?

> Probe/remove match the Linux driver
> model better, but wouldn't map as well to device tree which isn't supposed
> to be influenced by Linux.

I'm trying to keep orthogonal to the device tree here, trying to take
that into account for everything just burns me out and distorts
focus currently. We can always refactor or translate whatever the
DT discussions lead up to.

>> + ? ? /*
>> + ? ? ?* Make a copy of the config state array - string pointers will end up
> ...
>> + ? ? pinconf_states = tmp;
>> + ? ? pinconf_states_num += num_states;
>
> We need to allow multiple tables to be registered, for all the same
> reasons we do for the pinmux mapping table. This implementation only
> keeps the most recently registered table.

? beats me.

Please check the code for how I realloc the tmp variable (in the v2
patch set), I cannot spot the problem. It was designed to allow exactly
multiple calls to add tables piece by piece.

The rest are fixed as I addressed yours, Dongs and Thomas' comments,
or so I hope.

Thanks,
Linus Walleij
