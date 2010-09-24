From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 24 Sep 2010 15:07:38 +0100
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<20100923213654.0c64b047@lxorguk.ukuu.org.uk>
	<20100924131407.GA3113@riccoc20.at.omicron.at>
	<20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
Message-ID: <20100924150738.744297d0@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You can't do that avoiding as you might like because the behaviour of
> file handle numbering is defined by the standards. Hence the "f*"
> versions of the calls (and of lots of other stuff)
> 
> Whether you add new syscalls or do the fd passing using flags and hide
> the ugly bits in glibc is another question.

To add an example of what I mean you might end up defining "CLOCK_FD" to
indicate to use the fd in the struct, but given syscalls are trivial
codewise and would end up as

	fclock_foo(int fd, blah)
	{
		clock = fd_to_clock(fd);
		if (error)
			return error
		clock_do_foo(clock, blah);
		clock_put(clock);
	}

and

	clock_foo(int posixid, blah)
	{
		clock = posix_to_clock(posixid)
		...
		rest same
	}

as wrappers it seems hardly worth adding ugly hacks
