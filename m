From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 23:54:24 +0200
Subject: [PATCH v3] ARM: default machine descriptor for multiplatform
In-Reply-To: <5171B7F8.4040601@gmail.com>
References: <1365779468-116419-1-git-send-email-arnd@arndb.de>
 <201304191640.32139.arnd@arndb.de> <5171B7F8.4040601@gmail.com>
Message-ID: <201304192354.25065.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Rob Herring wrote:
> This will fail to build for !OF. of_platform.h needs this:
> 
> #define of_default_bus_match_table NULL
> 
> You may need some struct forward declarations, but this commit in my
> tree for 3.10 should fix those:
> 
> commit d450f445f9a654080a6be4094376c2192d9a1f36
> Author: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Date:   Tue Feb 19 02:58:25 2013 +0300
> 
>     <linux/of_platform.h>: fix compilation warnings with DT disabled
> 

Ok. I've actually stumbled over missing declarations from of_platform.h
and related files a number of times. Could we please not hide any
declarations inside of #ifdef when there is no #else alternative?

If we just show the of_default_bus_match_table declaration in the
header file, there is no need to provide the silly NULL macro,
since the of_platform_populate alternative will just ignore it.

I'll just put the code in an #ifdef for now, but I'd really prefer
to clean up this and many other locations that currently have
to do #ifdef CONFIG_OF when they really don't need to.

	Arnd
