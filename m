From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 12 Jul 2016 15:03:40 -0700
Subject: FPGA manager user space interface
In-Reply-To: <alpine.DEB.2.02.1607120922060.1804@linuxheads99>
References: <5782BE1A.9090905@gmail.com>
 <alpine.DEB.2.02.1607111014500.11060@linuxheads99>
 <5783D99D.2090402@gmail.com>
 <alpine.DEB.2.02.1607120922060.1804@linuxheads99>
Message-ID: <5785693C.7070704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2016 08:15 AM, atull wrote:
> On Mon, 11 Jul 2016, Florian Fainelli wrote:
> 
>> Hi Alan,
>>
>> On 07/11/2016 09:59 AM, atull wrote:
>>> On Sun, 10 Jul 2016, Florian Fainelli wrote:
>>>
>>> Hi Florian,
>>>
>>> I'm in the process of upstreaming FPGA Regions support which
>>> allows reprogramming by applying Device Tree Overlays.  If you
>>> want to see a tree which has the latest patches for that, I have
>>> all that in our github tree.
>>>
>>> https://github.com/altera-opensource/linux-socfpga/tree/socfpga-4.6
>>>
>>> The documentation for the DT overlays is in
>>>  Documentation/devicetree/bindings/fpga/fpga-region.txt
>>>
>>> Documentation for the DT configfs interface is in
>>>  Documentation/devicetree/configfs-overlays.txt
>>>
>>> The idea here is explained at legnth in the doc, but basically
>>> the user can use the configfs interface to apply a DT
>>> overlay that causes the FPGA to be reprogrammed and child
>>> devices to get added and probed.
>>>
>>> I like DT overlays a lot, but I do not expect that (or anything
>>> else) will be a good interface for every use case.  The FPGA
>>> Manager Framework went through a legnthy discussion on the
>>> mailing list where several people wanted the interface to match
>>> what they were already using.  Interfaces similar to what you
>>> suggest below were proposed and shot down.  My conclusion from
>>> all that was to implement the kernel API functions such that
>>> people could add whatever interfaces they needed for their use
>>> case.
>>
>> While I agree that the current state of the FPGA manager is completely
>> sane, and people making products including a FPGA will want something
>> (kernel driver or user-space scripts) that load a given set of bistreams
>> (under version control), it still feels like there is a small bit of
>> debugging and or use cases where it is desireable to have a way, from
>> user-space to load an arbitrary FPGA bitstream which is not set in stone
>> from e.g: a Linux kernel driver. More than being able to change
>> something on the filesystem, it's about being able to reload the
>> bitstream from user-space that seems to be critically missing imho.
>>
> 
> Did you look into DT overlays?  DT overlays can be applied from
> userspace using the configfs interface.  The FPGA Region code
> will handle bridges and loading the nodes for the child devices.
> You can also remove the overlay, the child devices will be
> unloaded and the bridges disabled so you can iterate during your
> development.

I did, and this is solving one aspect of working with FPGAs which is how
to represent the different devices they offer, but this is not quite
what my question nor concerns are about, those were more about the
debugability and working with

> 
>> Do you have links to the original discussion so I could get an idea of
>> what were the different points back then?
>>
>> Thanks!
> 
> Exposing reprogramming in sysfs or as a char driver was rejected
> as:
> * it makes it easy to do the wrong thing and crash your system
> * it didn't give us a way of showing the heirarchy of what a
> system with multiple fpgas and bridges could have.

That is true, and it is also pretty much true with any Linux device
driver unless you have special code that parses the hierarchy in /sys
(which should happen regardless if you need to care bout hierarchy).

> * It makes it difficult to know which fpga you are reprogramming
> if you are doing 'cat image > /dev/fpga0' since your system may
> have several fpgas.

My out of tree code creates on /dev/fpgaX where X matches what the FPGA
manger ida returns, so there is a strict 1:1 mapping between the two,
and, the character device is bound to the backing device of the FPGA
manager, so that does not seem like an actual concern.

> * Your system may have bridges between the cpu and the fpga.
> Those will need to be mapped not only to the fpga they are
> connected to, but more finely than that.  Some fpga images
> need different bridges to be enabled/disabled.
> 
> When dynamic device trees started to become a reality in
> the kernel, that was a natural solution to a lot of this.

Keep in mind that DT overlays are a tool to solve one very specific
problem: representing accurarely what a FPGA device provides and making
sure that Linux's device driver model adheres to that, but it does not
solve the other part of my question which is, given an existing
framework, how do I load arbitraty bistreams because my workflow
involves working on the bistream more than the FPGA manager driver which
is just the host side of the development tools.

> 
> Feel free to google the lkml archives you want more details.  The
> reason I am opposed to it now is it that is begging for the
> system to be crashed by doing a simple operation from userspace.
> And it makes it impossible to export to userspace the kind
> of control that the user needs except perhaps in only
> the most simple system.

That part is absolutely fair in a multi-FPGA system with complex
bridging and or daisy chaining, although I don't really see anything
that could not be solvable by having proper parenting between devices
and therefore knowing the topology, and that should already exist thanks
to DT overlays and/or careful parenting (e.g: through MFD).

> 
> Here's a few easy ways to crash your system if you can reprogram
> from userspace:
> 1. Reprogram the FPGA without shutting down the bridges first.
> Spurious data goes out onto a processor bus and things get hosed.

This seems to be a similar, if not yet identical problem to doing system
suspend/resume, and the device driver model should help you figure out
the parenting of peripherals and allow shutting them down before you can
reconfigure the FPGA with a new bistream and set of peripherals.

> 2. Program the FGPA, load some drivers to support the hw in
> the FPGA, then reprogram the FPGA.
> 3. Program the FPGA using DT overlays and then use sysfs
> as a back door to program it again.
> 4. A system with multiple FPGAs will need to be brought up
> or reconfigured in a sensible order.  DT overlays can be
> applied on top of dt overlays, bringing up the system in
> order.

Same thing here, the device driver model helps you, and to get an
accurate device driver model, DT is one option, but not the only one.

Thanks for sharing your thoughts, I am not going to argue we need a
character device for debugging/programming, and I am okay with keeping
this code out of tree for my own development purposes.

> 
> Alan
> 
>>
>>>
>>>
>>>> Hi all,
>>>>
>>>> I just wrote a FPGA manager driver for the TS-7300 board which features
>>>> an Altera Cyclone II on board. While the finished solution is my case
>>>> might be something like the MFD driver for the FPGA devices requesting
>>>> the bitstream load and registering the different devices it exposes,
>>>> during development it is nice to exercise the FPGA manager driver to
>>>> load something:
>>>
>>> It sounds like your goal is to use the FPGA Manager API inside
>>> the kernel, but it would be helpful to have an easy userspace
>>> interface during development.  Is that right?
>>>
>>>>
>>>> - a quick way is to add a pair of sysfs attributes to define the
>>>> bitstream filename and to trigger the load
>>>>
>>>> - offer a more consistent and robust interface through e.g; a character
>>>> device that you can write/read/poll to see the loading progress about
>>>
>>> Sysfs and char driver interfaces have been proposed and shot down
>>> a few times already.
>>>
>>> The first version of the FPGA Manager Framework was a char
>>> driver.  To program the FPGA, the user had to do 'cat
>>> bitstream-file > /dev/fpga0'.  Bridge support was a separate
>>> thing that was also controlled by sysfs.  It was messy and if
>>> userspace could easily do the wrong thing and crash the system.
>>>
>>>>
>>>> - have the driver exposing FPGA peripherals be exposing an user space
>>>> interface to trigger a (re)load/(re)/configuration, although that's
>>>> really something that belongs in the FPGA manager it seems
>>>
>>> If you use the device tree configfs interface, you can do that.
>>> It might not be exactly what you are thinking of.  And there is
>>> a learning curve in getting the overlays right.
>>>
>>>>
>>>> I am mostly curious if these were taken into account during the initial
>>>> design and it is agreed upon that yes these are some of options and that
>>>> userspace loading is just anecdotal we do not need any userspace
>>>> interface, or if this is just missing and we want one?
>>>
>>> There will be use cases that will need various userspace interfaces.
>>> It's been hard to get people who are already using FPGAs to agree
>>> on using any one interface because they would have to change the
>>> code they already have running.
>>>
>>>> Either way, I
>>>> don't mind submitting what I came up with for the TS-7300 board.
>>>
>>> Yes, that would be great.
>>>
>>>>
>>>> Thanks!
>>>> --
>>>> Florian
>>>>
>>
>>
>> -- 
>> Florian
>>


-- 
Florian
