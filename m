From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 15:35:09 +0100
Subject: [PATCH] lz4c: shut up lz4c output
In-Reply-To: <56D44065.4070005@suse.com>
References: <1456749618-1067584-1-git-send-email-arnd@arndb.de>
 <56D44065.4070005@suse.com>
Message-ID: <2781274.5SXPMrqOdg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 13:58:13 Michal Marek wrote:
> On 2016-02-29 13:40, Arnd Bergmann wrote:
> > When KERNEL_LZ4 is set, we always get an output even when building
> > with 'make -s':
> > 
> >     *** LZ4 Compression CLI , by Yann Collet (May 31 2013) ***
> >     ! Generating compressed LZ4 using Legacy format (deprecated !) !
> >     Using stdin for input
> >     Using stdout for output
> >     Compressed 11213376 bytes into 4555781 bytes ==> 40.63%
> >     Done in 0.63 s ==> 16.97 MB/s
> > 
> > The output is not helpful in the context of building the kernel,
> > so this patch hides the stdout output of the lz4 binary completely.
> 
> > -     lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ || \
> > +     lz4c -l -c1 stdin stdout && $(call size_append, $(filter-out FORCE,$^))) > $@ 2>&1 || \
> >       (rm -f $@ ; false)
> 
> Hi Arnd,
> 
> this redirection does not hide it, but rather includes it in the
> compressed image file.

Oops, you are right. I was cleaning out some older patches I had in my
queue and hadn't realized it was completely botched this way.

> BTW, my copy of lz4c only displays this warning with -v.

I've updated my copy of lz4c now and can confirm that the output
is completely gone (without -v). I won't follow up with a fixed version
then, as the problem is already solved elsewhere.

	Arnd
