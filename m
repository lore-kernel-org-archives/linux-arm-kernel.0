From: robherring2@gmail.com (Rob Herring)
Date: Sat, 18 Sep 2010 15:58:34 -0500
Subject: [PATCH 0/4] CPU hotplug support for Versatile platforms
In-Reply-To: <20100917230127.GA19718@n2100.arm.linux.org.uk>
References: <1284729124-15297-1-git-send-email-will.deacon@arm.com>
	<4C93DBE6.2040103@gmail.com>
	<20100917230127.GA19718@n2100.arm.linux.org.uk>
Message-ID: <4C9527FA.2030803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2010 06:01 PM, Russell King - ARM Linux wrote:
> On Fri, Sep 17, 2010 at 04:21:42PM -0500, Rob Herring wrote:
>> The platform specific SMP code is one area that prevents supporting a
>> single kernel image. All the functions in platsmp.c need to be converted
>> to function pointers and a lot of that code is pretty simliar across
>> platforms. What's needed is a common platsmp.c with something like
>> platform specific smp_ops like PowerPC. I think addressing that first
>> would simplify this restructuring as you are doing some of what's
>> needed, but you introducing new namespace problems like platform_cpu_*.
>
> The split between smp.c and platsmp.c is there to allow different SMP
> implementations from the standard ARM Ltd SMP implementation (and there
> will be different implementations.)
>
> Just because all the SMP implementations that are currently merged are
> the standard ARM Ltd SMP implementation does not mean that we should
> move stuff out of platsmp.c into the generic code.

Agreed, but the interface between smp.c and platsmp.c does not allow for 
more than one SMP platform in a single image. Granted, there are plenty 
of other obstacles to multi-platform kernel binaries, but this one would 
be good to address before there are a bunch of SMP platforns rather than 
after. Ideally, platsmp.c could be common, but optional for platforms 
that are significantly different.

The idea I have is add a smp_init function ptr to struct mdesc which 
would fill in an smp_ops struct of function pointers and call 
set_cpu_possible for each core. This would replace the direct 
smp_init_cpus call.

Rob
