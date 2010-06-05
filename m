From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 4 Jun 2010 23:59:02 -0600
Subject: Boot interface for device trees on ARM
In-Reply-To: <alpine.LFD.2.00.1006042212400.30664@xanadu.home>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005191055180.12758@xanadu.home>
	<AANLkTilhqg270l-_m9raalqAPPRhvLJD9omHe8ysgLjg@mail.gmail.com>
	<201006050933.06714.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1006042212400.30664@xanadu.home>
Message-ID: <AANLkTin_PpsY6_hWKtJ9HZqk4nhEO0mcD5TdKpq0KbYk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 4, 2010 at 8:29 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 5 Jun 2010, Jeremy Kerr wrote:
>> > hmmm... however, things the device tree blob and the initrd both need
>> > to be marked as bootmem at paging_init() time, but init_machine()
>> > doesn't run until later. ?There will still need to be some hooks for
>> > doing early DT processing, but none of that should be either board or
>> > SoC specific.
>>
>> If we're planning to keep the machine IDs around (even if they are now per-
>> SoC), I'd like to know what would be left using them. The only thing that I
>> can see that we currently use is io_pg_offset for the DEBUG_LL builds, and
>> that isn't a convincing case to keep them.
>
> Why not?
>
> Kernel infrastructure backward compatibility means that you need to keep
> struct machine_desc instances around. ?Granted, for the DT case, many of
> the members could be NULL or initialized with dummy stubs. ?But that is
> very cheap to keep around, and that allows the same kernel binary to be
> able to use both the DT boot and the legacy boot.

I agree with Nicolas on this point.  He's convinced me that machine id
without ATAGs is sufficient to deal with the backwards compatibility
issues.  I have no problem with making machine_id in r1 part of the
boot requirements.

That being said; each DT must still be fully-formed.  Every DT still
needs a top level compatible property to uniquely identify the
machine.  If it turns out that Linux can ignore the machine ID and
rely solely on the DT data, then so be it.  I actually don't care much
since then it is just an internal Linux kernel implementation detail.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
