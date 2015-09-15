From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 15 Sep 2015 15:08:01 +0200
Subject: [PATCH v3 02/18] of/platform: add of_platform_probe
In-Reply-To: <20150911153530.GM20922@sirena.org.uk>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-3-git-send-email-tomeu.vizoso@collabora.com>
 <20150807121913.GS20873@sirena.org.uk>
 <CAAObsKCrakupiZMQ9AoiWo6fDYT6Cfi_khdssUS6pv61zYS1Zg@mail.gmail.com>
 <CAAObsKAZ0kaT2TZQdMnxy9ZjHMz2jFeYQvQjrCsa90J11bOVpA@mail.gmail.com>
 <20150911095748.GC12027@sirena.org.uk>
 <CAAObsKAaxBJUH=u-2VSDGUQ6CsqpATpF-48LHEtvd3FD3_prsQ@mail.gmail.com>
 <20150911153530.GM20922@sirena.org.uk>
Message-ID: <CAAObsKAgMu=Y8C=7uJhNq1uWyE2rtu4uNj-d3V3kXEHfRpBqfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2015 at 17:35, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Sep 11, 2015 at 04:06:07PM +0200, Tomeu Vizoso wrote:
>
>> Once a platform device (with the platform bus as its parent) is
>> retrieved from the deferred queue, both the parent and the device in
>> question are locked (because of the USB stuff mentioned below). If
>> that device depends on another device whose parent is the platform bus
>> and we try to probe it (useless, but I don't see a good way of
>> avoiding it) then we'll deadlock when device_attach locks that device.
>
> Ugh, that's nasty.  Trying to fix this would most likely devolve into
> trying to shove things onto the deferred list in the right order but
> that's definitely a very different solution with problems.

Well, that's effectively what my "ordered probing" series did (and
indeed didn't have this problem and parents were made sure to have
probed before their children), but if we want to have dependency
information before the probe starts, then we cannot reuse the
implementation of the DT bindings that we already have in the resource
getters as this series do.

Regards,

Tomeu
