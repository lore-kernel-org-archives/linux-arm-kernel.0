From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 02:32:41 +0800
Subject: [hisi:topic-lpc-4.10-libio 136/148] lib/libio.c:80:13: error:
 dereferencing pointer to incomplete type 'struct acpi_resource'
Message-ID: <201702070238.HMQTlBwF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

First bad commit (maybe != root cause):

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: 1138304d3967f65dac8be95ce39f9abffc5f1f65 [136/148] libio: create from extio
config: x86_64-acpi-redef (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 1138304d3967f65dac8be95ce39f9abffc5f1f65
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   lib/libio.c:24:28: warning: 'struct extio_node' declared inside parameter list will not be visible outside of this definition or declaration
    void register_extio(struct extio_node *node)
                               ^~~~~~~~~~
   lib/libio.c: In function 'register_extio':
   lib/libio.c:27:21: error: dereferencing pointer to incomplete type 'struct extio_node'
     list_add_tail(&node->list, &extio_dev_list);
                        ^~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   lib/libio.c: In function 'find_extio_token':
   include/linux/list.h:463:43: error: dereferencing pointer to incomplete type 'struct extio_node'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                               
   include/linux/kernel.h:850:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
>> lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(extio_entry, &extio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:45:43: warning: 'struct fwnode_handle' declared inside parameter list will not be visible outside of this definition or declaration
    struct extio_node *extio_find_node(struct fwnode_handle *node)
                                              ^~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   lib/libio.c: In function 'extio_find_node':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:50:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:59:38: warning: 'struct fwnode_handle' declared inside parameter list will not be visible outside of this definition or declaration
    unsigned long extio_translate(struct fwnode_handle *node,
                                         ^~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   lib/libio.c: In function 'extio_translate':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:66:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &extio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
>> lib/libio.c:78:57: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
                                                            ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_extio_supported_resource':
>> lib/libio.c:80:13: error: dereferencing pointer to incomplete type 'struct acpi_resource'
     switch (res->type) {
                ^~
>> lib/libio.c:81:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS16' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS16:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:81:7: note: each undeclared identifier is reported only once for each function it appears in
>> lib/libio.c:82:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS32' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS32:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/libio.c:83:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS64' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS64:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
>> lib/libio.c:89:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_count_extiores(struct acpi_resource *res,
           ^~~~~~~~~~~
   lib/libio.c:89:47: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static acpi_status acpi_count_extiores(struct acpi_resource *res,
                                                  ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_count_extiores':
   lib/libio.c:94:36: error: passing argument 1 of 'acpi_extio_supported_resource' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (acpi_extio_supported_resource(res) &&
                                       ^~~
   lib/libio.c:78:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> lib/libio.c:95:4: error: implicit declaration of function 'acpi_dev_filter_resource_type' [-Werror=implicit-function-declaration]
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:95:39: error: 'IORESOURCE_IO' undeclared (first use in this function)
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
                                          ^~~~~~~~~~~~~
>> lib/libio.c:98:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^~~~~
   lib/libio.c: At top level:
   lib/libio.c:101:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_read_one_extiores(struct acpi_resource *res,
           ^~~~~~~~~~~
   lib/libio.c:101:50: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static acpi_status acpi_read_one_extiores(struct acpi_resource *res,
                                                     ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_read_one_extiores':
   lib/libio.c:106:36: error: passing argument 1 of 'acpi_extio_supported_resource' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (acpi_extio_supported_resource(res) &&
                                       ^~~
   lib/libio.c:78:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:107:39: error: 'IORESOURCE_IO' undeclared (first use in this function)
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
                                          ^~~~~~~~~~~~~
>> lib/libio.c:108:35: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
      memcpy((*resource), res, sizeof(struct acpi_resource));
                                      ^~~~~~
   lib/libio.c:109:14: error: dereferencing pointer to incomplete type 'struct acpi_resource'
      (*resource)->length = sizeof(struct acpi_resource);
                 ^~
   lib/libio.c:109:32: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
      (*resource)->length = sizeof(struct acpi_resource);
                                   ^~~~~~
>> lib/libio.c:111:14: error: increment of pointer to an incomplete type 'struct acpi_resource'
      (*resource)++;
                 ^~
   lib/libio.c:114:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^~~~~
   lib/libio.c: At top level:
   lib/libio.c:117:8: error: unknown type name 'acpi_status'
    static acpi_status
           ^~~~~~~~~~~
>> lib/libio.c:119:11: warning: 'struct acpi_buffer' declared inside parameter list will not be visible outside of this definition or declaration
       struct acpi_buffer *buffer)
              ^~~~~~~~~~~
>> lib/libio.c:118:37: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
    acpi_build_extiores_template(struct acpi_device *adev,
                                        ^~~~~~~~~~~
   lib/libio.c: In function 'acpi_build_extiores_template':
>> lib/libio.c:121:2: error: unknown type name 'acpi_handle'
     acpi_handle handle = adev->handle;
     ^~~~~~~~~~~
>> lib/libio.c:121:27: error: dereferencing pointer to incomplete type 'struct acpi_device'
     acpi_handle handle = adev->handle;
                              ^~
   lib/libio.c:123:2: error: unknown type name 'acpi_status'
     acpi_status status;
     ^~~~~~~~~~~
>> lib/libio.c:126:11: error: implicit declaration of function 'acpi_walk_resources' [-Werror=implicit-function-declaration]
     status = acpi_walk_resources(handle, METHOD_NAME__PRS,
              ^~~~~~~~~~~~~~~~~~~
>> lib/libio.c:126:39: error: 'METHOD_NAME__PRS' undeclared (first use in this function)
     status = acpi_walk_resources(handle, METHOD_NAME__PRS,
                                          ^~~~~~~~~~~~~~~~
>> lib/libio.c:128:6: error: implicit declaration of function 'ACPI_FAILURE' [-Werror=implicit-function-declaration]
     if (ACPI_FAILURE(status) || !res_cnt) {
         ^~~~~~~~~~~~
>> lib/libio.c:129:3: error: implicit declaration of function 'dev_err' [-Werror=implicit-function-declaration]
      dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
      ^~~~~~~

vim +80 lib/libio.c

14c67d09 lib/extio.c zhichang.yuan 2017-01-23   30  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   31  static struct extio_node *find_extio_token(unsigned long addr)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   32  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   33  	struct extio_node *extio_entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   34  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   35  	read_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23  @36  	list_for_each_entry(extio_entry, &extio_dev_list, list) {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   37  		if ((addr < extio_entry->io_start + extio_entry->range_size) &&
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   38  			(addr >= extio_entry->io_start))
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   39  			break;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   40  	}
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   41  	read_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   42  	return (&extio_entry->list == &extio_dev_list) ? NULL : extio_entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   43  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   44  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   45  struct extio_node *extio_find_node(struct fwnode_handle *node)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   46  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   47  	struct extio_node *entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   48  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   49  	read_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   50  	list_for_each_entry(entry, &extio_dev_list, list) {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   51  		if (entry->fwnode == node)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   52  			break;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   53  	}
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   54  	read_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   55  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   56  	return (&entry->list == &extio_dev_list) ? NULL : entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23  @57  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   58  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   59  unsigned long extio_translate(struct fwnode_handle *node,
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   60  		unsigned long bus_addr)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   61  {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   62  	struct extio_node *entry;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   63  	unsigned long port_id = -1;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   64  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   65  	read_lock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23  @66  	list_for_each_entry(entry, &extio_dev_list, list) {
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   67  		if (entry->fwnode == node &&
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   68  			bus_addr >= entry->bus_start &&
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   69  			bus_addr - entry->bus_start < entry->range_size)
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   70  			port_id = entry->io_start + bus_addr -
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   71  					entry->bus_start;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   72  	}
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   73  	read_unlock(&extio_list_lock);
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   74  
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   75  	return port_id;
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   76  }
14c67d09 lib/extio.c zhichang.yuan 2017-01-23   77  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @78  static inline bool acpi_extio_supported_resource(struct acpi_resource *res)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   79  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @80  	switch (res->type) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @81  	case ACPI_RESOURCE_TYPE_ADDRESS16:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @82  	case ACPI_RESOURCE_TYPE_ADDRESS32:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @83  	case ACPI_RESOURCE_TYPE_ADDRESS64:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   84  		return true;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   85  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   86  	return false;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   87  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   88  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @89  static acpi_status acpi_count_extiores(struct acpi_resource *res,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   90  					   void *data)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   91  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   92  	int *res_cnt = data;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   93  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @94  	if (acpi_extio_supported_resource(res) &&
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @95  		!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   96  		(*res_cnt)++;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   97  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  @98  	return AE_OK;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24   99  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  100  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  101  static acpi_status acpi_read_one_extiores(struct acpi_resource *res,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  102  		void *data)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  103  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  104  	struct acpi_resource **resource = data;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  105  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @106  	if (acpi_extio_supported_resource(res) &&
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  107  		!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @108  		memcpy((*resource), res, sizeof(struct acpi_resource));
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  109  		(*resource)->length = sizeof(struct acpi_resource);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  110  		(*resource)->type = res->type;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @111  		(*resource)++;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  112  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  113  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @114  	return AE_OK;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  115  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  116  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @117  static acpi_status
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @118  acpi_build_extiores_template(struct acpi_device *adev,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @119  			struct acpi_buffer *buffer)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  120  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @121  	acpi_handle handle = adev->handle;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  122  	struct acpi_resource *resource;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @123  	acpi_status status;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  124  	int res_cnt = 0;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  125  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @126  	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  127  				     acpi_count_extiores, &res_cnt);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @128  	if (ACPI_FAILURE(status) || !res_cnt) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @129  		dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  130  		return -EINVAL;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  131  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  132  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @133  	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @134  	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  135  	if (!buffer->pointer)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  136  		return -ENOMEM;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  137  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  138  	resource = (struct acpi_resource *)buffer->pointer;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  139  	status = acpi_walk_resources(handle, METHOD_NAME__PRS,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  140  				     acpi_read_one_extiores, &resource);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  141  	if (ACPI_FAILURE(status)) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @142  		kfree(buffer->pointer);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  143  		dev_err(&adev->dev, "can't evaluate _PRS: %d\n", status);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  144  		return -EINVAL;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  145  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  146  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @147  	resource->type = ACPI_RESOURCE_TYPE_END_TAG;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  148  	resource->length = sizeof(struct acpi_resource);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  149  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  150  	return 0;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  151  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  152  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @153  static int acpi_translate_extiores(struct acpi_device *adev,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  154  		struct acpi_device *host, struct acpi_buffer *buffer)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  155  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @156  	int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  157  	struct acpi_resource *resource = buffer->pointer;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @158  	struct acpi_resource_address64 addr;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  159  	unsigned long sys_port;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @160  	struct device *dev = &adev->dev;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  161  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  162  	/* only one I/O resource now */
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  163  	if (res_cnt != 1) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  164  		dev_err(dev, "encode %d resources whose type is(%d)!\n",
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  165  			res_cnt, resource->type);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  166  		return -EINVAL;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  167  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  168  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @169  	if (ACPI_FAILURE(acpi_resource_to_address64(resource, &addr))) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  170  		dev_err(dev, "convert acpi resource(%d) as addr64 FAIL!\n",
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  171  			resource->type);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  172  		return -EFAULT;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  173  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  174  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  175  	/* For indirect-IO, addr length must be fixed. (>0, 0, 0) */
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  176  	if (!addr.address.address_length || addr.min_address_fixed ||
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  177  		addr.max_address_fixed) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @178  		dev_warn(dev, "variable I/O resource is invalid!\n");
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  179  		return -EINVAL;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  180  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  181  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  182  	sys_port = extio_translate(&host->fwnode, addr.address.minimum);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  183  	if (sys_port == -1) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  184  		dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  185  			addr.address.minimum);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  186  		return -EFAULT;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  187  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  188  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  189  	switch (resource->type) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  190  	case ACPI_RESOURCE_TYPE_ADDRESS16:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  191  	{
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  192  		struct acpi_resource_address16 *out_res;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  193  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  194  		out_res = &resource->data.address16;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @195  		out_res->address.minimum = sys_port;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  196  		out_res->address.maximum = sys_port +
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  197  			addr.address.address_length - 1;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  198  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @199  		dev_info(dev, "_SRS 16IO: [0x%x - 0x%x]\n",
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  200  			out_res->address.minimum,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  201  			out_res->address.maximum);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  202  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  203  		break;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  204  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  205  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @206  	case ACPI_RESOURCE_TYPE_ADDRESS32:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  207  	{
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  208  		struct acpi_resource_address32 *out_res;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  209  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  210  		out_res = &resource->data.address32;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @211  		out_res->address.minimum = sys_port;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  212  		out_res->address.maximum = sys_port +
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  213  			addr.address.address_length - 1;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  214  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  215  		dev_info(dev, "_SRS 32IO: [0x%x - 0x%x]\n",
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  216  			out_res->address.minimum,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  217  			out_res->address.maximum);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  218  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  219  		break;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  220  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  221  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  222  	case ACPI_RESOURCE_TYPE_ADDRESS64:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  223  	{
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  224  		struct acpi_resource_address64 *out_res;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  225  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  226  		out_res = &resource->data.address64;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @227  		out_res->address.minimum = sys_port;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  228  		out_res->address.maximum = sys_port +
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  229  			addr.address.address_length - 1;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  230  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  231  		dev_info(dev, "_SRS 64IO: [0x%llx - 0x%llx]\n",
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  232  			out_res->address.minimum,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  233  			out_res->address.maximum);
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  234  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  235  		break;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  236  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  237  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  238  	default:
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  239  		return -EINVAL;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  240  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  241  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  242  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  243  	return 0;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  244  }
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  245  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  246  /*
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  247   * update/set the current I/O resource of the designated device node.
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  248   * after this calling, the enumeration can be started as the I/O resource
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  249   * had been translated to logicial I/O from bus-local I/O.
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  250   *
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  251   * @adev: the device node to be updated the I/O resource;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  252   * @host: the device node where 'adev' is attached, which can be not
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  253   *	the parent of 'adev';
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  254   *
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  255   * return 0 when successful, negative is for failure.
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  256   */
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @257  int acpi_set_extio_resource(struct acpi_device *adev,
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  258  		struct acpi_device *host)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  259  {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @260  	struct device *dev = &adev->dev;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @261  	struct acpi_buffer buffer;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  262  	acpi_status status;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  263  	int ret;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  264  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  265  	if (!host)
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  266  		return -EINVAL;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  267  
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  268  	/* check the device state */
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  269  	if (!adev->status.present) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  270  		dev_info(dev, "ACPI: device is not present!\n");
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  271  		return 0;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  272  	}
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  273  	/* whether the child had been enumerated? */
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24 @274  	if (acpi_device_enumerated(adev)) {
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  275  		dev_info(dev, "ACPI: had been enumerated!\n");
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  276  		return 0;
0ccaa690 lib/extio.c zhichang.yuan 2017-01-24  277  	}

:::::: The code at line 80 was first introduced by commit
:::::: 0ccaa690913e8dc13f3bbdfff3c059dc3c2ae936 LPC: Add the ACPI LPC support

:::::: TO: zhichang.yuan <yuanzhichang@hisilicon.com>
:::::: CC: zhichang.yuan <yuanzhichang@hisilicon.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/879f8ab8/attachment-0001.gz>
