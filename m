From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 4 Mar 2015 23:34:54 +0900
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <20150304142943.GU28951@e104818-lin.cambridge.arm.com>
References: <20150220153626.GB10942@hawk.usersys.redhat.com>
 <20150224145529.GA5498@hawk.usersys.redhat.com>
 <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
 <20150302163146.GB9686@lvm> <54F51A63.4060302@samsung.com>
 <20150304113505.GS28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8OUtcpaQh5+gb6vNrdi+Q7eu_zKOujmyoRPrzrs+GJVQ@mail.gmail.com>
 <20150304122956.GT28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-JnvXFzr-fpjZZ-zTt8hOSfGqefw69s+4JX2iu_6_BMw@mail.gmail.com>
 <20150304141212.GA5352@hawk.usersys.redhat.com>
 <20150304142943.GU28951@e104818-lin.cambridge.arm.com>
Message-ID: <CAFEAcA-kDDhkoC0hU1PD7YbW_JFx+ucVFu7iTa7soTtMPZumiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 23:29, Catalin Marinas <catalin.marinas@arm.com> wrote:
> I disagree it is 100% a host-side issue. It is a host-side issue _if_
> the host tells the guest that the (virtual) device is non-coherent (or,
> more precisely, it does not explicitly tell the guest that the device is
> coherent). If the guest thinks the (virtual) device is non-coherent
> because of information passed by the host, I fully agree that the host
> needs to manage the cache coherency.
>
> However, the host could also pass a "dma-coherent" property in the DT
> given to the guest and avoid any form of cache maintenance. If the guest
> does not honour such coherency property, it's a guest problem and it
> needs fixing in the guest. This isn't any different from a real physical
> device behaviour.

Right, and we should do that for things like virtio, because we want
the performance. But we also have devices (like vga framebuffers)
which shouldn't be handled as cacheable, so we need to be able to
deal with both situations.

-- PMM
