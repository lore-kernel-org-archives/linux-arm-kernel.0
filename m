From: robherring2@gmail.com (Rob Herring)
Date: Thu, 6 Aug 2015 15:19:12 -0500
Subject: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
In-Reply-To: <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 9:11 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> Delay matches of platform devices with OF nodes until late_initcall,
> when we are sure that all built-in drivers have been registered already.
> This is needed to prevent deferred probes because of some drivers not
> having registered yet.
>
> The reason why only platform devices are delayed is that some other
> devices are expected to be probed earlier than late_initcall, for
> example, the system PNP driver needs to probe its devices in
> fs_initcall.
>
> Additionally, only platform devices with OF nodes are delayed because
> some machines may depend on oter platform devices being registered at
> specific times.

How do we know that these probes occur before the unused clocks and
regulators are turned off? Just getting lucky (as is deferred probe)?
Can we do this one level earlier so we have a level left to do things
after probe.

Rob
