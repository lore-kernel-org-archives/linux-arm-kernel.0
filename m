From: benh@au1.ibm.com (Benjamin Herrenschmidt)
Date: Mon, 10 Apr 2017 07:53:55 +1000
Subject: [PATCH v4 19/23] drivers/fsi: Add GPIO based FSI master
In-Reply-To: <1491774092.4166.195.camel@kernel.crashing.org>
References: <20170329174340.89109-1-cbostic@linux.vnet.ibm.com>
 <20170329174340.89109-20-cbostic@linux.vnet.ibm.com>
 <CACPK8XfOSYPidHF6=psC4mP-tkRyWTu0psdcK6EwA2E6FF53Uw@mail.gmail.com>
 <0e1bcf3a-e8d7-9f50-bdf7-2a1e7466665b@linux.vnet.ibm.com>
 <1490907014.3177.207.camel@kernel.crashing.org>
 <93b21624-11fc-b71b-aa78-6cb4371c87ae@linux.vnet.ibm.com>
 <1491344360.4166.68.camel@kernel.crashing.org>
 <5344146a-f450-7959-4688-a83ee022574b@linux.vnet.ibm.com>
 <1491774092.4166.195.camel@kernel.crashing.org>
Message-ID: <1491774835.4166.197.camel@au1.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-04-10 at 07:41 +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2017-04-09 at 16:22 -0500, Christopher Bostic wrote:
> > A 3 microsecond delay is required, however, to prevent occasional
> > issues?
> > during heavy FSI bus load stress testing.
> > A 1 nanosecond delay using ndelay(1) had been specified prior to
> > this?
> > but after looking more closely at real time performance it turned
> > out to?
> > actually be roughly 1-2 microseconds.?? This appears to be the
> > minimum?
> > resolution using the delay() linux libraries on the
> > AST2400/2500.???
> > Given this, increasing delay to 3 microseconds doesn't impact?
> > performance much considering I can now remove the sample input
> > delay?
> > based on your recommendations to re-order the two clock delays.
> 
> This is huge delays. We should consider a AST2xxx specific variant of
> the backend that uses nops or similar lab-calibrated constructs
> instead. Otherwise we are stuck in the kHz range, this is a >200Mhz
> bus
> :)
> 
> I don't understand why 3us delay would thus be necessary.
> 
> Where about did you observe issues ? Could it be that you don't wait
> long enough in the transitions from write to read ?

FYI. pdbg in userspace operates without any  delays in practice, the
overhead between the various load/store instructions seems sufficient.

The only delay that's needed is when going through the FSI2PIB (to do
SCOMs) where it seems like back-2-back accesses can be problematic.

Cheers,
Ben
