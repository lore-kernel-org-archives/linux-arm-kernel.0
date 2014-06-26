From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Thu, 26 Jun 2014 14:34:17 +0200
Subject: [PATCH RFC v2 3/8] component: add support for component match
 array
In-Reply-To: <E1WzWOy-0007zc-36@rmk-PC.arm.linux.org.uk>
References: <20140624192830.GC20555@n2100.arm.linux.org.uk>
 <E1WzWOy-0007zc-36@rmk-PC.arm.linux.org.uk>
Message-ID: <CA+gwMcdO5P-Yu+-FeHHGxkKwObsATL-ThVDwmEm2_cZ3enUXPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Jun 24, 2014 at 9:29 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
[...]
> +/*
> + * Add a component to be matched.
> + *
> + * The match array is first created or extended if necessary.
> + */
> +void component_match_add(struct device *dev, struct component_match **matchptr,
> +       int (*compare)(struct device *, void *), void *compare_data)
> +{
> +       struct component_match *match = *matchptr;
> +
> +       if (IS_ERR(match))
> +               return;
> +
> +       if (!match || match->num == match->alloc) {
> +               size_t new_size = match ? match->alloc + 16 : 15;
> +
> +               match = component_match_realloc(dev, match, new_size);
> +
> +               *matchptr = match;
> +
> +               if (IS_ERR(match))
> +                       return;
> +       }
> +
> +       match->compare[match->num].fn = compare;
> +       match->compare[match->num].data = compare_data;
> +       match->num++;
> +}

component_match_add should be exported.

regards
Philipp
