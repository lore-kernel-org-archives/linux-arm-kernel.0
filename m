From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 17:33:09 +0100
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007112149.GB22530@linux>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux> <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux>
Message-ID: <20151007163309.GM21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 04:51:49PM +0530, Viresh Kumar wrote:
> On 07-10-15, 12:07, Greg Kroah-Hartman wrote:
> > Why would you be wanting to create a "unsigned long" as an api anyway?
> > Just force it to be u64 all the time, can't you do that?
> 
> Okay, so the variable in question (lets say frequency) is an 'unsigned
> long' and that's how all the APIs of clock framework expect/define
> it.
> 
> And you are probably saying that we do this:
> 
> unsigned long freq;
> 
> debugfs_create_u64((u64 *)&freq);
> 
> Right? Or are you asking to update clock APIs to be converted to u64?

Don't you even think about doing that - that's totally broken no matter
what, and this is a good example of why casts are Bad.

debugfs_create_u64() will create a debugfs object that will want to
access a 64-bit value, but the value pointed to is only 32-bit.  The
net result is that the debugfs file ends up reading or writing the
neigbouring 32-bits, which may potentially be unaligned.

The variable pointed to for debugfs_create_u64() must be a 64-bit
value.  No casts allowed.

An alternative would be to have debugfs_create_ulong() or similar
which has accessors for standard C types.

I don't think forcing subsystems wanting to use debugfs to have to use
u{8,16,32,64} types for internal data is on - these are for things that
we want to say "we want this to be a 8, 16, 32 or 64-bit type
respectively" which is not what most subsystems need to do with
internal data.  This looks like a debugfs cockup to me. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
