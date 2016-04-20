From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 20 Apr 2016 18:58:21 -0500
Subject: [PATCH 00/14] DT: Fix spelling of standard properties
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAL_Jsq+JO41w2PweW0n1Z78=wPnYh+wfa==Hb8o37L3ynDndkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>         Hi all,
>
> This patch series fixes misspellings of various standard DT properties
> in DT binding documentation, DTS files, and error messages.
> While most of these are harmless, some of them may cause hard-to-debug
> failures.
>
> Please apply where appropriate.

I'll happily take the whole series if you like, though I've not
reviewed it all yet.

>
> Thanks!
>
> P.S. I used the following to detect misspellings:
>
>     words="(address|clock|cooling|dma|gpio|index|interrupt|mbox|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"
>
>     git grep -Ew "${words}s-names"
>     git grep -E "[^-]\<${words}-name\>[^-]"
>     git grep -Ew "#${words}s-cells"             # false positive phys-cells
>     git grep -E "#${words}-cell\>[^-]"
>
>     git grep -w adress-cells
>     git grep -Ew "interrupts-(map|parent)"
>
> How can we prevent adding more of these?
>
> One simple option is to add the offenders to scripts/spelling.txt.
> Alternatively, we may want to do something smarter and more DT specific?

At least for #*-cells, we should be able to check most in dtc. When we
find common properties, we can check the node for the phandle has a
cells property. That would also check that the property is in fact a
phandle.

For *-names, we might be able to do a generic check in dtc for the
corresponding property being present when we find a -names property.
Though I suspect we're not consistent enough when/where we use plural.

Rob
