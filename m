From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 10:01:10 -0700
Subject: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for cpu
 domain
In-Reply-To: <5574121F.2000806@samsung.com> (Krzysztof Kozlowski's message of
 "Sun, 07 Jun 2015 18:42:55 +0900")
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <5574121F.2000806@samsung.com>
Message-ID: <7hbngnpkfd.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> W dniu 05.06.2015 o 07:29, Lina Iyer pisze:
>> Generally cpus are grouped under a power domain in a SoC. When all cpus
>> in the domain are in their power off state,
>
> What do you exactly mean here by "CPU in power off state"? How does it
> map to kernel understanding of CPU device (hotplug? cpuidle?)?
>
>> the cpu domain can also be
>> powered off. Genpd provides the framework for defining cpus as devices
>> that are part of a cpu domain.
>
> The problem which is solved looks to me like the same problem which
> coupled cpuidle tried to solve: a certain deep sleep mode (e.g. power
> off) can be entered when whole cluster is idle or other CPUs in cluster
> are powered off completely.
>
> It seems a little like duplicating the effort around coupled cpuidle.

Yes, it duplicates some aspects of coupled idle states, but coupled
states have their own limitations:

- only handles CPUs, not other devices sharing a power rail (e.g. L2$,
  GIC, floating point unit, CoreSight, etc. etc.)

- not scaling well past 2 CPUs

- doesn't handle clusters: While this series only addresses CPUs
  currently, the approach can be extended.  Because genpd handles nested
  domains, the could be used to model clusters as well.

Kevin
