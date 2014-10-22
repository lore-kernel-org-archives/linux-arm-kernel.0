From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 22 Oct 2014 08:03:45 +0200
Subject: [PATCH] ARM: don't set unused name in struct flash_platform_data
In-Reply-To: <20141022055326.GB16128@brian-ubuntu>
References: <1411993853-6309-1-git-send-email-zajec5@gmail.com>
 <20141022055326.GB16128@brian-ubuntu>
Message-ID: <CACna6rw8dG4+nBkgNb+A_xfom=4rjh-nXJGeQ=4GgWHcZMJwMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 October 2014 07:53, Brian Norris <computersforpeace@gmail.com> wrote:
> On Mon, Sep 29, 2014 at 02:30:53PM +0200, Rafa? Mi?ecki wrote:
>> Loading correct SPI driver (m25p80) is handled using modalias from the
>> struct spi_board_info. There is no point of setting name in the
>> platform_data, m25p80 ignores it anyway.
>
> Wait, is 'name' actually ignored? It looks to me like it sets the MTD
> name. See the comments in include/linux/spi/flash.h and
> arch/arm/include/asm/mach/flash.h (BTW, why do we have two definitions
> for this??):
>
>   @name: optional flash device name (eg, as used with mtdparts=)
>
> And I think it's used for exactly that in m25p80.c:
>
>         if (data && data->name)
>                 flash->mtd.name = data->name;

And very few lines later in the m25p80.c you have this:
if (data && data->type)
        id = spi_nor_match_id(data->type);

Code I touched in my patch was using both: name and type. So what you
got it "type" took a precedence and "name" value was ignored. It seems
like ppl used to use "name" to trigger "m25p80" probe, which isn't
needed (it's done by SPI layer).

Also see my comment about data->type usage I added in:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=32f1b7c8352fd33d41bcec3cfb054ccdcfd40a42
