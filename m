From: dwmw2@infradead.org (David Woodhouse)
Date: Tue, 21 Mar 2017 09:42:23 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <20170321073452.GA17298@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
 <20170317153358.GI5940@leverpostej>
 <1489765628.17202.59.camel@infradead.org>
 <20170317162421.GK5940@leverpostej> <20170321073452.GA17298@linaro.org>
Message-ID: <1490089343.5036.92.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-03-21 at 16:34 +0900, AKASHI Takahiro wrote:
> Yes, it is intentional. I removed 'offline' code in my v14 (2016/3/4).
> As you assumed, I'd expect 'online' status of all CPUs to be kept
> unchanged in the core dump.

I wonder if it would be better to take a *copy* of it and put it back
after we're done taking the CPUs down? As things stand, we now have
*three* different methods of taking down all the CPUs... and *none* of
them allow a platform to override it with an NMI-based or STONITH-based 
method, which seems like something of an oversight.

> If you can agree, I would like to modify this disputed warning code to:
>?
> +	BUG_ON(!in_kexec_crash && (stuck_cpus || (num_online_cpus() > 1)));
> +	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
> +		"Some CPUs may be stale, kdump will be unreliable.\n");

That works; thanks.

FWIW I'm currently blaming my platform's firmware for my sporadic
crash-on-CPU#1 failures. If your testing includes crashes on non-boot
CPUs (perhaps using the sysrq hack I posted) and it reliably passes for
you, then let's ignore that for now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170321/3266da88/attachment-0001.bin>
