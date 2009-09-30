From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Wed, 30 Sep 2009 14:21:57 -0400 (EDT)
Subject: apparently, numerous unused header files under arch/arm
In-Reply-To: <20090930144603.GC25416@huya.quicinc.com>
References: <alpine.LFD.2.00.0909300405080.14643@localhost>
	<20090930144603.GC25416@huya.quicinc.com>
Message-ID: <alpine.LFD.2.00.0909301416560.20750@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2009, David Brown wrote:

> On Wed, Sep 30, 2009 at 01:12:22AM -0700, Robert P. J. Day wrote:
>
> > is there any interest in my posting that arm-specific list
> > somewhere and people can peruse it and decide what, if anything,
> > they want to do with it?
>
> Any chance the script itself could be made available?  I would find
> this useful as I'm working through large amounts of code to get it
> to a state where it can be sent out as patches.

  an embarrassingly brute force approach -- most of my scripts are
just tweaked variations of the following.  run from whatever
location you want, and customize to taste:

===== start script =====

#!/bin/sh

#  This script should always be run from the *top* of the kernel
# source tree.
#
#  Typical usage:
#
#  $ find_unused_headers.sh sound
#
#  Make sure you run some version of "make clean" before running
# this script.

DIR=${1-*}     # optional dir to scan, otherwise "."

#  Make a list of all of the header files in the given directory
# structure, and rip off their basenames.

LONGHDRS=$(find ${DIR} -name "*.h")

HDRS=""

for h in ${LONGHDRS} ; do
	HDRS="${HDRS} $(basename ${h})"
done

#
#  just for fun, process them in sorted order
#

HDRS=$(for h in ${HDRS} ; do echo $h ; done | sort -u)

# echo "${HDRS}"

#
#  Test that each header file is included from *somewhere*.
#

for h in ${HDRS} ; do
	# echo "Testing $h ..."
	egrep -rwq " *# *include.*\b${h}\b" * || {
		echo "===== ${h} ====="
		find . -name "${h}"
		grep -rwH ${h} *
	}
done

===== end script =====

  that last "grep" is simply to scan the *entire* source tree, looking
for that header file name *anywhere*, and that's what might reveal
that it's being used by something somewhere else, like in a Makefile.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
