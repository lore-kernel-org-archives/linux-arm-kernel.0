From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 17 Mar 2017 15:33:58 +0000
Subject: [PATCH v33 00/14] add kdump support
In-Reply-To: <1489759373.17202.44.camel@infradead.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
 <1489750991.17202.40.camel@infradead.org>
 <1489759373.17202.44.camel@infradead.org>
Message-ID: <20170317153358.GI5940@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 02:02:53PM +0000, David Woodhouse wrote:
> On Fri, 2017-03-17 at 11:43 +0000, David Woodhouse wrote:
> > 
> > Is this one going to be be my fault too?
> 
> Looks like it isn't my fault. In ipi_cpu_crash_stop() we don't modify
> the online mask. Which is reasonable enough if we want to preserve its
> original contents from before the crash, but it does make that
> WARN_ON() in machine_kexec() a false positive.

I'd say it's not so much a false positive, but rather an uninformative
message.

Some warning here is completely appropriate. Even if the CPUs are
stopped in the kernel, there are a number of cases where the HW can
corrupt system state in the background.

We can certainly log a better message, e.g.
	
	bool kdump = (image == kexec_crash_image);
	bool stuck_cpus = cpus_are_stuck_in_kernel() ||
			  num_online_cpus() > 1;

	BUG_ON(stuck_cpus && !kdump);
	WARN(stuck_cpus, "Unable to offline CPUs, kdump will be unreliable.\n");

Thanks,
Mark.
