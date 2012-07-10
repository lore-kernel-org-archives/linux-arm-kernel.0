From: sjg@chromium.org (Simon Glass)
Date: Tue, 10 Jul 2012 14:10:44 +0200
Subject: [PATCH 1/1] of: introduce helper to manage boolean
In-Reply-To: <20120313041652.563B63E0536@localhost>
References: <1328588028-24766-1-git-send-email-plagnioj@jcrosoft.com>
 <20120309014441.8236B3E0903@localhost>
 <20120309100435.GN27213@game.jcrosoft.org>
 <20120309162638.92E813E0880@localhost>
 <20120309163608.GQ27213@game.jcrosoft.org>
 <4F5E50DA.6080000@freescale.com>
 <20120313031739.GA18320@game.jcrosoft.org>
 <20120313041652.563B63E0536@localhost>
Message-ID: <CAPnjgZ2dj5pcuGhM2_2nwwnhhcCmKhyi6jVHS7Xf1f682i_j_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 13, 2012 at 5:16 AM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Tue, 13 Mar 2012 04:17:39 +0100, Jean-Christophe PLAGNIOL-VILLARD <
> plagnioj at jcrosoft.com> wrote:
> > On 14:39 Mon 12 Mar     , Scott Wood wrote:
> > > On 03/09/2012 10:36 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > >>>> Ugh.  so any value other than 1 returns false?  I think that will
> surprise
> > > >>>> most people.
> > > >>>>
> > > >>>> I don't like this api or binding.  If it is a bool property, then
> why isn't
> > > >>>> simply testing for the property existance sufficient?
> > > >>> no if you want to disable it
> > > >>>
> > > >>> if a bool is define in the dtsi and want to disable it int the dts
> > > >>>
> > > >>> if you we can do the the invert
> > > >>>
> > > >>> if !0 => true
> > > >>>
> > > >>> is-ok;                  => true
> > > >>> is-ok = <val != 0>;     => true
> > > >>> is-ok = <0>;            => false
> > > >>
> > > >> This is a failure of the dtc tool, not the binding.  Accepting this
> binding
> > > >> means we have to live with it for a very long time.  It needs to be
> fixed
> > > >> in dtc instead so that properties can be deleted instead of only
> modified.
> > > > I understand your idea but today if you put and value in the
> property it's true.
> > > >
> > > > So is-ok = <0>; is true also which is illogical as in any language a
> boolean is
> > > > true (1) or false (0). When I read the property I will understand
> false not true
> > >
> > > You could say similar things about is-ok = "no" or is-ok = "" or is-ok
> =
> > > "I'd rather you didn't"... it's expected that violating the binding may
> > > produce illogical results.
> > today is most of the binding people use a number whe the want to be able
> to
> > delete it and it's the same in most of the promgramming language
>
> It isn't yet a big pain point, so there isn't time pressure here.  Fixing
> the tool
> is the better solution, and since the kernel carries a copy of the tool we
> don't
> need to worry about adding a feature that isn't available by the dtc
> packaged by
> a distribution.
>
> Fixing the tool is the correct thing to do.
>

I just wanted to pick up on this thread. Now in the kernel, absence of a
property indicates false, and presence indicates true. This is a kernel
convention, nothing to do with the dtb format. I think it is useful to
support a boolean with a non-null value which can be 0, meaning true as
Jean-Christophe says.

My reasons are:

1. dtc does not have a way to delete a property and it isn't clear what
syntax could be used there. It also seems a little brittle to delete a
property in one place and define it in another (ordering? confusion when
people can't work out why it has gone?). So not only can dtc not do this,
but I'm not sure that it should.

2. fdtput allows updating a property. It is pretty easy to do something
like 'fdtput file.dtb /node propname $value' where value is 0 or 1. To use
the current binding we need to either do:

if [[ $value == 0 ]]; then
   fdtput -d file.dtb /node propname   # new function to delete a property?
else
   fdtput file.dtb /node propname 1
fi

or perhaps something like:

   fdtput -B file.dtb /node propname ${value}

where -B is a new option meaning either create an empty property, or delete
any property it finds, based on the value being 0 or non-zero.

3. Discoverability: it is nice to be able to see the possible options, even
if disabled. In particular, if a boolean value is true, and you later
decide with fdtput to turn it off, you effectively remove all trace of it.
This could be confusing for those who are looking for available options.

Arguably these issues could be fixed if we introduced some sort of type
hinting into the dtb file format, but that seems a long shot. I am not sure
that modifying the tools to support this arguable odd 'present/absent'
boolean binding is the right approach.

So I think Jean-Christophe's idea has significant merit.

Thoughts?

Regards,
Simon

>
> g.
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120710/80a0c4e9/attachment-0001.html>
