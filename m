From: daniel.vetter@ffwll.ch (Daniel Vetter)
Date: Thu, 26 Apr 2018 11:39:09 +0200
Subject: [Linaro-mm-sig] noveau vs arm dma ops
In-Reply-To: <20180426092422.GA26825@infradead.org>
References: <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
 <20180425064335.GB28100@infradead.org> <20180425074151.GA2271@ulmo>
 <20180425085439.GA29996@infradead.org>
 <20180425100429.GR25142@phenom.ffwll.local>
 <20180425153312.GD27076@infradead.org>
 <20180425225443.GQ16141@n2100.armlinux.org.uk>
 <CAKMK7uG9R6paoP4BmvqDVUP_4Db4Dz8MSXeLwUBMYaORa5-kVw@mail.gmail.com>
 <20180426092422.GA26825@infradead.org>
Message-ID: <CAKMK7uEK_KjjWUwsiFPW1KmUkjy2j8tA_R4zc5u1gJ6BHRfAVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 11:24 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Apr 26, 2018 at 11:20:44AM +0200, Daniel Vetter wrote:
>> The above is already what we're implementing in i915, at least
>> conceptually (it all boils down to clflush instructions because those
>> both invalidate and flush).
>
> The clwb instruction that just writes back dirty cache lines might
> be very interesting for the x86 non-coherent dma case.  A lot of
> architectures use their equivalent to prepare to to device transfers.

Iirc didn't help for i915 use-cases much. Either data gets streamed
between cpu and gpu, and then keeping the clean cacheline around
doesn't buy you anything. In other cases we need to flush because the
gpu really wants to use non-snooped transactions (faster/lower
latency/less power required for display because you can shut down the
caches), and then there's also no benefit with keeping the cacheline
around (no one will ever need it again).

I think clwb is more for persistent memory and stuff like that, not so
much for gpus.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
