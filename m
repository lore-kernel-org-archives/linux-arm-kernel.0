From: neko@bakuhatsu.net (Matt Sealey)
Date: Thu, 1 Aug 2013 15:04:50 -0500
Subject: Defining schemas for Device Tree
In-Reply-To: <CAKON4OwY3xh3UGjTxb4ypkcmrTpVYO-FZovq-ierabYMf4CDQA@mail.gmail.com>
References: <2469263.vMN09Q7Tzi@flatron> <51F6E30B.7060106@wwwdotorg.org>
 <CAKON4Oy6+7ZpAG5emAm_c62t=o_LXM7PcbK-z5YL_qx=r0AKqQ@mail.gmail.com>
 <1706112.Xn49tiCSKF@thinkpad>
 <CAKON4OwNrhmvnznyeD-igtZ5nsm7atUZoa0RJttN5kmwKubaDg@mail.gmail.com>
 <20130730102511.GM9858@sirena.org.uk>
 <CAKON4OxSr13VPJkwkvuF91BwFXfQ6fkAuVeEsiA=JK3cuzmavQ@mail.gmail.com>
 <51F7F596.6020503@wwwdotorg.org>
 <CAKON4OykPqYA8+ZGxjiX00Ut+iM9hqiXr5D9KEZF3PVxoqiM1g@mail.gmail.com>
 <51F7F914.6040709@wwwdotorg.org>
 <CAKON4Oy6hL9LzHdfq4vWcurbw6TU3HCK_jq14xwweA8dvOGtdw@mail.gmail.com>
 <51F7FCA6.6010909@wwwdotorg.org>
 <CAKON4OzLgC-ahDhLnbYEYrSj7dbFRU0z7Do_D32XNqux2UhvXw@mail.gmail.com>
 <CAKON4OyMfNUR=NGn+OEvN3utcEzRfG6A4rPO6+h5Q4mq_tmoxw@mail.gmail.com>
 <51F80526.1020201@wwwdotorg.org>
 <CAKON4OwY3xh3UGjTxb4ypkcmrTpVYO-FZovq-ierabYMf4CDQA@mail.gmail.com>
Message-ID: <CAHCPf3vf-AjKeuq1GX2gVn3-+DZhpFO1z9XqsKMAHZr2uh4n6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 1:28 PM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> On Tue, Jul 30, 2013 at 2:25 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 07/30/2013 12:04 PM, jonsmirl at gmail.com wrote:
>> ...
>>> So what does an alternating use of strings do?
>>>
>>>  dmas = "tx", <&pdma0 7>, "rx", <&pdma0 6>;
>
> Ok, so this won't work without introducing variable length data. Too
> bad, I would have liked to eliminate the paired attributes.

It would be nice to eliminate things from device trees and do them
differently but right now, pairs like clocks and clock-names and dmas
and dma-names are basically so common, you're talking about cleaning
it up and affecting everyone and every board with a change.

There's really not a lot of code reduction you'd get in parsing and
fetching data just by using a single property vs. paired properties.

You're right, in the sense that a (in devicetree.org semantics)
"mixed-property" is the logical way to go here (bear with me, though),
this would be eminently supported by every device-tree-using system in
the world, ever - because properties are just encoded values. A string
should (and usually is..) not encoded directly in a property but in
some place elsewhere and a pointer to it is created. That string in
FDT should be in this indirect table of strings. Inside OF it would be
a Forth string (1 byte with the length, then the string, no NULL
terminator) and the 'pointer' (if you pushed it to the Forth stack)
would be to the size byte.

Context is king here. It doesn't matter what you put in a property but
*how you parse it* and how you parse it is entirely defined by the
binding.

1275 and it's related bindings did a very good job of defining
precisely the format and layout of every property on the basis of how
it is represented if you use the standard fetch method to pull it out,
you would get some reliable result - the "getprop" OFW service fills a
buffer you tell it to. You have to know and expect what you get back
in that buffer. You don't ask for strings or cells or a mix, just to
fill a buffer with whatever that property was. That is the defining
attribute for how FDT properties got done in the first instance.

What's not possible there, which makes it impractical, is to encode a
value that says "the string is here" in the middle of a mixed property
when using "getprop," which means nobody did it. You only gave it a
single buffer pointer and a length, not a place to put strings and a
place to put other values that refer to those strings..

It eases parsing anyway to split them into pairs, so people just
stopped mixing property types. Dealing with the same property type in
an array means no weird variable stepping over data.. to do it with a
phandle, string, int triple means copying the phandle out, moving a
buffer pointer, strlen on the string, and then knowing where to move
the buffer pointer to get the int at the end. Yuck. The whole
mixed-property thing worked great in Forth where you knew what you
pushed and when you popped it, it would still be a cell or a pointer
to a string. It's not great on the "OS" side.

I liked Mark's idea of using magic (preprocessor macros or "syntactic
sugar", either way) to generate pairs, but I relate to his later
comment; I really fear this starts to turn device tree authorship into
more of a chore than it already is. The more functionality you try and
shoe in to it, the more likely it will be to break (or more likely to
annoy people developing DTs). Preprocessing device trees is already
meaning the "source" for an FDT blob is no longer going to be much
like the output. I think that the point it turned a text file into a
compact, concise binary representation is where it should stop. That
text file needn't be full of macros and inheritance. It's starting to
become another programming language, and we're about 3 months away
from just saying "let's define our hardware platforms in Python and
build the interpreter right into Linux"

I'd rather hope that time was spent on maintaining the trees and
coming up with reasonable bindings and hardware descriptions based on
good knowledge of the history and reasoning behind a bunch of stuff
(education! I hope that the kernel summit list isn't on here for
nothing..) than constantly tweaking the infrastructure to compile
trees to output formats.. and changing those output formats.

~

What would help with defining FDTs is if someone could collect up all
the old and existing specifications and bindings and put them
somewhere and start referring to them in any bindings that reproduce
or change behaviors. The IEEE1275 spec is hard to get hold of, the
bindings are not always in "readable" (PostScript) formats. The
devicetree.org website has a bunch of broken links (and on the front
page, basically two different ePAPR specifications are linked) and
says it doesn't hope to redefine what is in the original (broken link)
or ePAPR (link to 2011 version) specs (footer: ePAPR link to the spec
from ~2008).

I got a couple bounces from devicetree-discuss at ozlabs with a note that
it had moved to devicetree at vger.kernel.org. That's fun, because
devicetree.org hasn't been updated to reflect it ;)

I may spend some time on the devicetree.org wiki but someone maybe
should do a review of the changes at some point. I am sure I saw a
tumbleweed go past when I typed it in to Firefox.

BTW if we're still looking for maintainers/'spirited individuals with
an opinion and more importantly, experience' on DTs, I'm up for it
(time willing).

-- Matt
