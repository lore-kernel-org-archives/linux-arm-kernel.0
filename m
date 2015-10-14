From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 14 Oct 2015 21:21:23 +0800
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <20151013164730.GF24353@leverpostej>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAFpQJXWzM644KsFWP9ei-k6gWgNVpBVT+UbY7NYdyfmyL=zMkw@mail.gmail.com>
 <CAFpQJXWFx2dQ_vv0POqkOiLe3eh9Ee=Sf+2Xx_08Vp=E4g6gLQ@mail.gmail.com>
 <20150930105331.GA10066@leverpostej>
 <CAFpQJXVegqortRLK+g7_9p82KMYwq0hg8n3_9bJqjGHsJvngaA@mail.gmail.com>
 <1443661547.2828.40.camel@kernel.crashing.org>
 <CAFpQJXXKcwks0iZN+3B=U0-9uYKFpAXcZE90GCHN9WyM45Hdpw@mail.gmail.com>
 <CAFpQJXUPWZxOWeJQnkw8E_voDoqhphH8iR-fr0xo0m3+FiL4sA@mail.gmail.com>
 <20151013164730.GF24353@leverpostej>
Message-ID: <561E56D3.3030105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 12:47 AM, Mark Rutland wrote:
>>> Hi Mark,
>>>
>>> i am thinking, if we could not address(or becomes complex)  these topologies
>>> using associativity,
>>> we should think of an alternate binding which suits existing and upcoming
>>> arm64 platforms.
>>> can we think of below numa binding which is inline with ACPI and will
>>> address all sort of topologies!
>>>
>>> i am proposing as below,
>>>
>>> 1. introduce "proximity" node property. this property will be
>>> present in dt nodes like memory, cpu, bus and devices(like associativity
>>> property) and
>>> will tell which numa node(proximity domain) this dt node belongs to.
>>>
>>> examples:
>>>                 cpu at 000 {
>>>                          device_type = "cpu";
>>>                          compatible = "cavium,thunder", "arm,armv8";
>>>                          reg = <0x0 0x000>;
>>>                          enable-method = "psci";
>>>                          proximity = <0>;
>>>                  };
>>>                 cpu at 001 {
>>>                          device_type = "cpu";
>>>                          compatible = "cavium,thunder", "arm,armv8";
>>>                          reg = <0x0 0x001>;
>>>                          enable-method = "psci";
>>>                          proximity = <1>;
>>>                  };
>>>
>>>         memory at 00000000 {
>>>                  device_type = "memory";
>>>                  reg = <0x0 0x01400000 0x3 0xFEC00000>;
>>>                  proximity =<0>;
>>>
>>>          };
>>>
>>>          memory at 10000000000 {
>>>                  device_type = "memory";
>>>                  reg = <0x100 0x00400000 0x3 0xFFC00000>;
>>>                  proximity =<1>;
>>>          };
>>>
>>> pcie0 at 0x8480,00000000 {
>>>                  compatible = "cavium,thunder-pcie";
>>>                  device_type = "pci";
>>>                  msi-parent = <&its>;
>>>                  bus-range = <0 255>;
>>>                  #size-cells = <2>;
>>>                  #address-cells = <3>;
>>>                  #stream-id-cells = <1>;
>>>                  reg = <0x8480 0x00000000 0 0x10000000>;  /*Configuration
>>> space */
>>>                  ranges = <0x03000000 0x8010 0x00000000 0x8010 0x00000000
>>> 0x70 0x00000000>, /* mem ranges */
>>>                           <0x03000000 0x8300 0x00000000 0x8300 0x00000000
>>> 0x500 0x00000000>;
>>>                 proximity =<0>;
>>>          };
>>>
>>>
>>> 2. Introduce new dt node "proximity-map" which will capture the NxN numa
>>> node distance matrix.
>>>
>>> for example,  4 nodes connected in mesh/ring structure as,
>>> A(0) <connected to> B(1) <connected to> C(2) <connected to> D(3) <connected
>>> to> A(1)
>>>
>>> relative distance would be,
>>>        A -> B = 20
>>>        B -> C  = 20
>>>        C -> D = 20
>>>        D -> A = 20
>>>        A -> C = 40
>>>        B -> D = 40
>>>
>>> and dt presentation for this distance matrix is :
>>>
>>>         proximity-map {
>>>               node-count = <4>;
>>>               distance-matrix = <0 0  10>,
>>>                                  <0 1  20>,
>>>                                  <0 2  40>,
>>>                                  <0 3  20>,
>>>                                  <1 0  20>,
>>>                                  <1 1  10>,
>>>                                  <1 2  20>,
>>>                                  <1 3  40>,
>>>                                  <2 0  40>,
>>>                                  <2 1  20>,
>>>                                  <2 2  10>,
>>>                                  <2 3  20>,
>>>                                  <3 0  20>,
>>>                                  <3 1  40>,
>>>                                  <3 2  20>,
>>>                                  <3 3  10>;
>>>            }
>>>
>>> the entries like < 0 0 > < 1 1>  < 2 2> < 3 3> can be optional and code can
>>> put default value(local distance).
>>> the entries like <1 0> can be optional if <0 1> and <1 0> are of same
>>> distance.
>> is this binding looks ok?
>
> This looks roughly requivalent to the ACPI SLIT, which means it's as
> powerful, which allays my previous concerns.

Cool, I think those bindings are quite extensible and easy understood.

Thanks
Hanjun
