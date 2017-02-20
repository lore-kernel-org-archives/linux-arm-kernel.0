From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2017 17:42:40 +0000
Subject: [PATCH v2 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <20170220172739.GN21222@n2100.armlinux.org.uk>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
 <20170220172739.GN21222@n2100.armlinux.org.uk>
Message-ID: <20170220174240.GO21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 05:27:39PM +0000, Russell King - ARM Linux wrote:
> No it is not.  As I already pointed out, the interrupt for the 8040 is
> GIC_SPI 71 _not_ GIC_SPI 77 as you have it in this series.
> 
> Both CP110's on Armada 8040 have a default mapping of ICU 77 to GIC 71.

For reference, here's the full boot-time mapping of the ICU.  I don't
know what's responsible for this mapping, but this is read directly
out of the ICU at kernel boot.

Format of the following table is:

ICU-irq => GIC-SPI-num Enable Edge/Level ICU-group

ICU mapping (/cp110-master/config-space at f2000000/interrupt-controller at 1e0000)
    0 =>  32    Lv 0
    1 =>  32    Lv 0
    2 =>  32    Lv 0
    3 =>  32    Lv 0
    4 =>  32    Lv 0
    5 =>  32    Lv 0
    6 =>  32    Lv 0
    7 =>  32    Lv 0
    8 =>  32    Lv 0
    9 =>  32    Lv 0
   10 =>  32    Lv 0
   11 =>  53 En Lv 4
   12 =>  32 En Lv 5
   13 =>  32    Lv 0
   14 =>  32    Lv 0
   15 =>  54 En Lv 4
   16 =>  55 En Lv 4
   17 =>  56 En Lv 4
   18 =>  57 En Lv 4
   19 =>  58 En Lv 4
   20 =>  59 En Lv 4
   21 =>  60 En Lv 4
   22 =>  32 En Lv 0
   23 =>  33 En Lv 0
   24 =>  34 En Lv 0
   25 =>  61 En Lv 4
   26 =>  33 En Lv 5
   27 =>  69 En Lv 0
   28 =>  32    Lv 0
   29 =>  32    Lv 0
   30 =>  32    Lv 0
   31 =>  32    Lv 0
   32 =>  32    Lv 0
   33 =>  35 En Lv 0
   34 =>  35 En Lv 0
   35 =>  35 En Lv 0
   36 =>  35 En Lv 0
   37 =>  32    Lv 0
   38 =>  36 En Lv 0
   39 =>  37 En Lv 0
   40 =>  38 En Lv 0
   41 =>  39 En Lv 0
   42 =>  40 En Lv 0
   43 =>  41 En Lv 0
   44 =>  42 En Lv 0
   45 =>  43 En Lv 0
   46 =>  44 En Lv 0
   47 =>  45 En Lv 0
   48 =>  46 En Lv 0
   49 =>  47 En Lv 0
   50 =>  48 En Lv 0
   51 =>  49 En Lv 0
   52 =>  50 En Lv 0
   53 =>  51 En Lv 0
   54 =>  52 En Lv 0
   55 =>  92 En Lv 0
   56 =>  93 En Lv 0
   57 =>  94 En Lv 0
   58 =>  95 En Lv 0
   59 =>  32    Lv 0
   60 =>  32    Lv 0
   61 =>  32    Lv 0
   62 =>  32    Lv 0
   63 =>  32    Lv 0
   64 =>  32    Lv 0
   65 =>  32    Lv 0
   66 =>  32    Lv 0
   67 =>  32    Lv 0
   68 =>  32    Lv 0
   69 =>  32    Lv 0
   70 =>  32    Lv 0
   71 =>  32    Lv 0
   72 =>  32    Lv 0
   73 =>  32    Lv 0
   74 =>  32    Lv 0
   75 =>  62 En Lv 4
   76 =>  70 En Lv 0
   77 =>  71 En Lv 0
   78 =>  53 En Lv 0
   79 =>  72 En Lv 0
   80 =>  73 En Lv 0
   81 =>  74 En Lv 0
   82 =>  75 En Lv 0
   83 =>  76 En Lv 0
   84 =>  77 En Lv 0
   85 =>  78 En Lv 0
   86 =>  79 En Lv 0
   87 =>  34 En Lv 5
   88 =>  54 En Lv 0
   89 =>  55 En Lv 0
   90 =>  56 En Lv 0
   91 =>  57 En Lv 0
   92 =>  58 En Lv 0
   93 =>  35 En Ed 5
   94 =>  63 En Lv 4
   95 =>  59 En Lv 0
   96 =>  36 En Lv 5
   97 =>  64 En Lv 4
   98 =>  37 En Lv 5
   99 =>  65 En Lv 4
  100 =>  38 En Ed 5
  101 =>  39 En Ed 5
  102 =>  60 En Lv 0
  103 =>  40 En Ed 5
  104 =>  41 En Ed 5
  105 =>  61 En Lv 0
  106 =>  62 En Lv 0
  107 =>  63 En Lv 0
  108 =>  66 En Lv 4
  109 =>  63 En Lv 0
  110 =>  67 En Lv 4
  111 =>  80 En Lv 0
  112 =>  81 En Lv 0
  113 =>  82 En Lv 0
  114 =>  68 En Lv 4
  115 =>  83 En Lv 0
  116 =>  69 En Lv 4
  117 =>  70 En Lv 4
  118 =>  85 En Lv 0
  119 =>  32    Lv 0
  120 =>  86 En Lv 0
  121 =>  87 En Lv 0
  122 =>  88 En Lv 0
  123 =>  89 En Lv 0
  124 =>  90 En Lv 0
  125 =>  91 En Lv 0
  126 =>  65 En Lv 0
  127 =>  66 En Lv 0
  128 =>  67 En Lv 0
  129 =>  68 En Lv 0
ICU mapping (/cp110-slave/config-space at f4000000/interrupt-controller at 1e0000)
    0 =>  32    Lv 0
    1 =>  32    Lv 0
    2 =>  32    Lv 0
    3 =>  32    Lv 0
    4 =>  32    Lv 0
    5 =>  32    Lv 0
    6 =>  32    Lv 0
    7 =>  32    Lv 0
    8 =>  32    Lv 0
    9 =>  32    Lv 0
   10 =>  32    Lv 0
   11 =>  53 En Lv 4
   12 =>  32 En Lv 5
   13 =>  32    Lv 0
   14 =>  32    Lv 0
   15 =>  54 En Lv 4
   16 =>  55 En Lv 4
   17 =>  56 En Lv 4
   18 =>  57 En Lv 4
   19 =>  58 En Lv 4
   20 =>  59 En Lv 4
   21 =>  60 En Lv 4
   22 => 256 En Lv 0
   23 => 257 En Lv 0
   24 => 258 En Lv 0
   25 =>  61 En Lv 4
   26 =>  33 En Lv 5
   27 =>  69 En Lv 0
   28 =>  32    Lv 0
   29 =>  32    Lv 0
   30 =>  32    Lv 0
   31 =>  32    Lv 0
   32 =>  32    Lv 0
   33 => 259 En Lv 0
   34 => 259 En Lv 0
   35 => 259 En Lv 0
   36 => 259 En Lv 0
   37 =>  32    Lv 0
   38 => 260 En Lv 0
   39 => 261 En Lv 0
   40 => 262 En Lv 0
   41 => 263 En Lv 0
   42 => 264 En Lv 0
   43 => 265 En Lv 0
   44 => 266 En Lv 0
   45 => 267 En Lv 0
   46 => 268 En Lv 0
   47 => 269 En Lv 0
   48 => 270 En Lv 0
   49 => 271 En Lv 0
   50 => 272 En Lv 0
   51 => 273 En Lv 0
   52 => 274 En Lv 0
   53 => 275 En Lv 0
   54 => 276 En Lv 0
   55 => 316 En Lv 0
   56 => 317 En Lv 0
   57 => 318 En Lv 0
   58 => 319 En Lv 0
   59 =>  32    Lv 0
   60 =>  32    Lv 0
   61 =>  32    Lv 0
   62 =>  32    Lv 0
   63 =>  32    Lv 0
   64 =>  32    Lv 0
   65 =>  32    Lv 0
   66 =>  32    Lv 0
   67 =>  32    Lv 0
   68 =>  32    Lv 0
   69 =>  32    Lv 0
   70 =>  32    Lv 0
   71 =>  32    Lv 0
   72 =>  32    Lv 0
   73 =>  32    Lv 0
   74 =>  32    Lv 0
   75 =>  62 En Lv 4
   76 =>  70 En Lv 0
   77 =>  71 En Lv 0
   78 => 277 En Lv 0
   79 =>  72 En Lv 0
   80 =>  73 En Lv 0
   81 =>  74 En Lv 0
   82 =>  75 En Lv 0
   83 =>  76 En Lv 0
   84 =>  77 En Lv 0
   85 =>  78 En Lv 0
   86 =>  79 En Lv 0
   87 =>  34 En Lv 5
   88 => 278 En Lv 0
   89 => 279 En Lv 0
   90 => 280 En Lv 0
   91 => 281 En Lv 0
   92 => 282 En Lv 0
   93 =>  35 En Ed 5
   94 =>  63 En Lv 4
   95 => 283 En Lv 0
   96 =>  36 En Lv 5
   97 =>  64 En Lv 4
   98 =>  37 En Lv 5
   99 =>  65 En Lv 4
  100 =>  38 En Ed 5
  101 =>  39 En Ed 5
  102 => 284 En Lv 0
  103 =>  40 En Ed 5
  104 =>  41 En Ed 5
  105 => 285 En Lv 0
  106 => 286 En Lv 0
  107 => 287 En Lv 0
  108 =>  66 En Lv 4
  109 => 287 En Lv 0
  110 =>  67 En Lv 4
  111 =>  80 En Lv 0
  112 =>  81 En Lv 0
  113 =>  82 En Lv 0
  114 =>  68 En Lv 4
  115 =>  83 En Lv 0
  116 =>  69 En Lv 4
  117 =>  70 En Lv 4
  118 =>  85 En Lv 0
  119 =>  32    Lv 0
  120 =>  86 En Lv 0
  121 =>  87 En Lv 0
  122 =>  88 En Lv 0
  123 =>  89 En Lv 0
  124 =>  90 En Lv 0
  125 =>  91 En Lv 0
  126 => 289 En Lv 0
  127 => 290 En Lv 0
  128 => 291 En Lv 0
  129 => 292 En Lv 0

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
