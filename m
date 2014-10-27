From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 27 Oct 2014 11:49:15 +0000
Subject: [PATCH v2 2/3] ARM: vfp: Fix VFPv3 hwcap detection on CPUID based
 cpus
In-Reply-To: <20141027103118.GA8768@arm.com> (Will Deacon's message of "Mon,
 27 Oct 2014 10:31:18 +0000")
References: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
 <1413294539-22069-3-git-send-email-sboyd@codeaurora.org>
 <20141027103118.GA8768@arm.com>
Message-ID: <yw1xppddwx50.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> Perhaps it would be better to consider exposing the ID registers to
> userspace in some manner? This could be done either via an undef handler, or
> using the vdso. We would add a (final) hwcap advertising this cpuid support.
> For big/little systems, the kernel would need to expose a suitable subset of
> the features (we already have the sanity checking code from Rutland).

This was discussed a few years ago, and some people raised various
objections.  Off the top of my head:

- Some features (e.g. VFP/NEON) need kernel support, and if this is not
  enabled, the actual system capabilities will not match the raw
  register value.  Fudging the values exposed to userspace would be
  fragile.
  (This argument has some merit.)

- Only v7 and newer CPUs have the CPUID registers.  Ridiculously old
  CPUs don't even have a CP15.  Providing synthetic values might be
  tricky.  Software thus needs to support alternate feature detection
  methods for such hardware.
  (This is true enough.)

- It would only be available on new kernels, so software would still
  need a fallback to another method for the foreseeable future.
  (This is a rather lazy argument.)

- It would be specific to Linux, so software can't rely on it anyway.
  (This is an even lazier argument.)

-- 
M?ns Rullg?rd
mans at mansr.com
